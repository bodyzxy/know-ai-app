import 'package:get/get.dart';

import '../model/message.dart';

class ChatPageController extends GetxController {
  HistoryMessage currHistoryMessage = HistoryMessage(id: "1", title: "test", messages: [], createTime: DateTime.now());


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