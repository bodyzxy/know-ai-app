import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  final isWaiting = false.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("AI对话"),
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
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 10),
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
                    OpenAIChatMessageRole.user.name  == currMessage.role
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
                suffixIcon: Obx(() => isWaiting.value
                    ? const CircularProgressIndicator(
                  color: Colors.blue,
                )
                    : GestureDetector(
                    onTap: () async {
                      final userInputText = _textEditingController.text;
                      if (userInputText.isEmpty) {
                        return;
                      }
                      isWaiting(true);
                      _textEditingController.clear();

                      await sendMessage(userInputText);
                      isWaiting(false);
                    },
                    child: const Icon(
                      Icons.send,
                      size: 30,
                    )))),
          ),
        )
    );
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
    _chatService.chat((resp) {
      log(resp);
    }, _chatController.currHistoryMessage.messages, options, prompt);
  }

}