import 'package:know_ai_app/constant/http_method.dart';
import 'package:know_ai_app/manager/network_manager.dart';
import 'package:know_ai_app/model/response/base_response.dart';

class TokenAPi {
  Future<Map<String, dynamic>> getAccessToken() async {
    NetworkManager networkManager = NetworkManager();
    networkManager.initialize();
    BaseResponse response = await networkManager
        .request('/api/v1/account/refresh-token', method: HttpMethod.post);
    return response.data['data'];
  }
}
