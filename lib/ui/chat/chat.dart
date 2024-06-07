import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/manager/asset_manager.dart';
import 'package:know_ai_app/model/dto/chat.dart';
import 'package:know_ai_app/service/chat_service.dart';

import '../../component/md_code_highlight_math.dart';
import '../../constant/constant.dart';
import '../../controller/chat.dart';
import '../../model/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatController = Get.find<ChatPageController>();
  final _chatService = ChatSSEService();
  final _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text(
            "AI对话",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<ChatPageController>(
          builder: (context) => ListView.builder(
              controller: _scrollController,
              itemCount: _chatController.currHistoryMessage.messages.length,
              itemBuilder: (context, index) {
                final currMessage =
                    _chatController.currHistoryMessage.messages[index];
                return Column(
                  crossAxisAlignment:
                      OpenAIChatMessageRole.user.name == currMessage.role
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment:
                            OpenAIChatMessageRole.user.name == currMessage.role
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            OpenAIChatMessageRole.user.name == currMessage.role
                                ? AssetManager.userIcon
                                : AssetManager.robotIcon,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            currMessage.role,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment:
                          OpenAIChatMessageRole.user.name == currMessage.role
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Card(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1, bottom: 1, left: 4, right: 4),
                            child: currMessage.content.isEmpty
                                ? const CircularProgressIndicator(
                                    backgroundColor: Colors.blue,
                                  )
                                : MdCodeMath(currMessage.content),
                          ),
                        ))
                      ],
                    )
                  ],
                );
              }),
        ),
        bottomNavigationBar: Container(
          margin:
              const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
          padding: MediaQuery.of(context).viewInsets,
          child: TextField(
            cursorColor: Colors.blue,
            controller: _textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                filled: true,
                hintText: "输入问题发起对话",
                prefixIcon: GestureDetector(
                  onTap: () async {
                    Get.defaultDialog(
                        title: "警告",
                        titleStyle: const TextStyle(color: Colors.red),
                        content: Column(
                          children: [
                            const Text("确定清空所有聊天记录?",style: TextStyle(fontSize: 18),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 15),

                                      decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: const Text(
                                          "取消",
                                          style: TextStyle(fontSize: 16,color: Colors.white)
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      _chatController.initDefault();
                                      Get.back();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff4691a8),
                                          borderRadius: BorderRadius.circular(15)),
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 15),

                                      child: const Text(
                                        "确定",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ))
                              ],
                            )
                          ],
                        )
                    );
                  },
                  child: const Icon(
                    Icons.cleaning_services_rounded,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
                suffixIcon: GestureDetector(
                    onTap: () async {
                      final userInputText = _textEditingController.text;
                      if (userInputText.isEmpty) {
                        return;
                      }
                      _textEditingController.clear();
                      updateToBottom();
                      await sendMessage(userInputText);
                    },
                    child: const Icon(
                      Icons.send,
                      size: 30,
                    ))),
          ),
        ));
  }

  Future<void> sendMessage(String prompt) async {
    _chatController.addMessage(Message(
        content: prompt,
        role: "user",
        historyId: _chatController.currHistoryMessage.id));

    _chatController.addMessage(Message(
        content: "",
        role: "assistant",
        historyId: _chatController.currHistoryMessage.id));

    var options = ChatOptions("gpt-3.5-turbo", 10, ChatType.SIMPLE, 0.9);
    var aiResponse = "";
    _chatService.chat((resp) {
      aiResponse = aiResponse + (resp['output']['content'] ?? "");
      _chatController.updateMessageContent(
          _chatController.currHistoryMessage.messages.length - 1, aiResponse);
      updateToBottom();
    }, _chatController.currHistoryMessage.messages, options, prompt);
  }

  void updateToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
