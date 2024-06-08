import 'package:get/get.dart';
import 'package:know_ai_app/api/token_refresh.dart';
import 'package:know_ai_app/storage/token_storage.dart';

class TokenController extends GetxController {

  final _tokenAPI = TokenAPi();
  final _tokenStorage = TokenStorage();


  Future<void> updateAccessKey() async {
    String refreshToken = await _tokenAPI.getAccessToken();
    await _tokenStorage.setAccessToken(refreshToken);
  }
}
