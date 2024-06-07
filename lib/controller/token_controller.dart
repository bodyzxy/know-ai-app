import 'package:get/get.dart';
import 'package:know_ai_app/api/token/token_refresh.dart';
import 'package:know_ai_app/storage/token_storage.dart';

class TokenController extends GetxController {
  void updateAccessKey() {
    Future<Map<String, dynamic>> data = TokenAPi().getAccessToken();
    data.then((value) async {
      String accessToken = value['accessToken'];
      String refreshToken = value['refreshToken'];

      await TokenStorage().deleteAllTokens();
      await TokenStorage().storeToken(accessToken, refreshToken);
    });
  }
}
