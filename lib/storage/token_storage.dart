import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//token管理
class TokenStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> setAccessToken(String token) async {
    await _storage.delete(key: "accessToken");
    await _storage.write(key: "accessToken", value: token);
  }

  Future<void> setRefreshToken(String token) async {
    await _storage.delete(key: "refreshToken");
    await _storage.write(key: "refreshToken", value: token);
  }


  Future<void> updateAccessToken(String token) async {
      await _storage.write(key: "accessToken", value: token);
  }

  Future<String> getAccessToken() async {
    return await _storage.read(key: 'accessToken')??"";
  }

  Future<String> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken')??"";
  }

  Future<void> deleteAllTokens() async {
    await _storage.deleteAll();
  }
}
