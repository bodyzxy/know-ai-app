import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:know_ai_app/api/token_refresh.dart';
import 'package:know_ai_app/config/request.dart';
import 'package:know_ai_app/model/response/authentication_response.dart';

import '../storage/token_storage.dart';

class UserApi {
  var tokenStorage = TokenStorage();
  var tokenApi = TokenAPi();

  Future<Map<String, dynamic>?> getUserInfo() async {
    var accessToken = await tokenStorage.getAccessToken();
    var dio = CustomizeDio.instance.getDio(token: accessToken);

    try {
      var rsp = await dio.get(ApiUrl.userInfo);
      return rsp.data['data'];
    } on DioException catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> jsonData) async {
    var dio = CustomizeDio.instance.getDio();
    try {
      var rsp = await dio.post(ApiUrl.login, data: jsonData);
      if (rsp.data['data'] != null) {
        var authTokens = AuthenticationResponse.fromJson(rsp.data['data']);
        tokenStorage.setAccessToken(authTokens.accessToken);
        tokenStorage.setRefreshToken(authTokens.refreshToken);
      }
      return rsp.data;
    } catch (e) {
      return {"code": "4001", "message": e.toString(), "data": e.toString()};
    }
  }

  Future<String> register(Map<String, dynamic> jsonData) async {
    var dio = CustomizeDio.instance.getDio();
    print("-=----------------$jsonData");
    var rsp = await dio.post(ApiUrl.register, data: jsonData);
    log(rsp.toString());
    print("=-=-=-=-=--=-=$rsp");
    return rsp.data['data'];
  }
}
