import 'package:get/get.dart';

import '../model/message.dart';

class ChatPageController extends GetxController {
  HistoryMessage currHistoryMessage = HistoryMessage(id: "1", title: "test", messages: [], createTime: DateTime.now());


  @override
  void onInit() {
    super.onInit();
    initDefault();
  }

  void initDefault() {
    currHistoryMessage.messages.clear();
    currHistoryMessage.messages.add(Message(content: "你好，我是你的AI小助理，有什么我可以帮助到你的吗？", role: "assistant", historyId: "1"));
    update();
  }

  void updateMessageContent(int index, String content) {
    currHistoryMessage.messages[index].content = content;
    update();
  }

  void addMessage(Message message) {
    currHistoryMessage.messages.add(message);
    update();
  }

  void reloadHistory() {
    update();
  }
  void setHistory(HistoryMessage history) {
    currHistoryMessage = history;
    update();
  }


}