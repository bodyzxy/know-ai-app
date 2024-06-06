import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:know_ai_app/handler/tpyedef.dart';
import 'package:know_ai_app/storage/token_storage.dart';

void ServerSSE(String context, Recall recall) async {
  String? accessToken = await TokenStorage().getAccessToken();

  late Future<Map<String, dynamic>> output;

  SSEClient.subscribeToSSE(
      method: SSERequestType.POST,
      url: "http://45.32.33.60:8818/api/v1/chat/stream",
      header: {
        "Content-Type": "application/json",
        "Accept": "text/event-stream",
        "Authorization": "Bearer $accessToken"
      },
      body: {
        "messages": [],
        "chatOptions": {
          "model": "gpt-3.5-turbo",
          "maxHistoryLength": 10,
          "chatType": "simple",
          "temperature": 0.8
        },
        "prompt": context
      }).listen((event) {
    recall(event);
  });
}
