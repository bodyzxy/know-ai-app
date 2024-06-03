import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:know_ai_app/model/response/authentication_response.dart';
import 'package:know_ai_app/model/response/base_response.dart';
import 'package:know_ai_app/model/response/string_response.dart';
import 'package:know_ai_app/utils/method/http_method.dart';
import 'package:know_ai_app/utils/network_manager.dart';
import 'package:know_ai_app/utils/token/token_storage.dart';

class HttpController extends GetxController {
  void loginRequest(Map<String, String> jsonData) async {
    // 创建 NetworkManager 实例
    NetworkManager networkManager = NetworkManager();
    // 配置 Dio 实例
    networkManager.initialize();
    BaseResponse response = await networkManager.request(
        '/api/v1/account/login',
        method: HttpMethod.post,
        data: jsonData);
    AuthenticationResponse authenticationResponse =
        AuthenticationResponse.fromJson(response.data['data']);
    //写入token
    TokenStorage().storeToken(authenticationResponse.accessToken,
        authenticationResponse.refreshToken);
  }

  void registerRequest(Map<String, dynamic> jsonData) async {
    // 创建 NetworkManager 实例
    NetworkManager networkManager = NetworkManager();
    // 配置 Dio 实例
    networkManager.initialize();
    BaseResponse response = await networkManager.request(
        '/api/v1/account/register',
        method: HttpMethod.post,
        data: jsonData);
    StringResponse stringResponse = StringResponse.formJson(response.data);
    if (kDebugMode) {
      print(stringResponse);
    }
  }
}
