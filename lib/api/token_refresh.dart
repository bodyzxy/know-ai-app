import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/config/request.dart';
import 'package:know_ai_app/storage/token_storage.dart';

class TokenAPi {
  Future<String> getAccessToken() async {
    var tokenStorage = TokenStorage();
    var refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken.isEmpty) return "";
    var dio = CustomizeDio.instance.getDio(token: refreshToken);
    try {
      var rsp = await dio.post(ApiUrl.refreshToken);
      return rsp.data['data'].toString();
    } on DioException catch (e) {
      // refreshToken过期
      if (e.response!.statusCode == 403) {
        tokenStorage.deleteAllTokens();
        Get.toNamed("/");
      }
      return "";
    }
  }
}
