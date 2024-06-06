import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:know_ai_app/model/dto/chat.dart';

import '../model/message.dart';
import '../storage/token_storage.dart';

class ChatSSEService {

  Future<void> chat(ValueChanged recall, List<Message> messages, ChatOptions options,
      String prompt) async {
    String? accessToken = await TokenStorage().getAccessToken();

    SSEClient.subscribeToSSE(
        method: SSERequestType.POST,
        url: "http://45.32.33.60:8818/api/v1/chat/stream",
        header: {
          "Content-Type": "application/json",
          "Accept": "text/event-stream",
          "Authorization": "Bearer $accessToken"
        },
        body: {
          "messages": messages,
          "chatOptions": options,
          "prompt": prompt
        }).listen((event) {
      Map<String,dynamic> mp = json.decode(event.data!);
      log(mp['result']);
      recall(mp['result']);
    });
  }
}
