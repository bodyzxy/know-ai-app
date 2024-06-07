import 'package:know_ai_app/constant/http_method.dart';
import 'package:know_ai_app/manager/network_manager.dart';
import 'package:know_ai_app/model/response/base_response.dart';

class UserApi {
  Future<Map<String, dynamic>> getUserInfo() async {
    NetworkManager networkManager = NetworkManager();
    networkManager.initialize();
    BaseResponse response = await networkManager.request('/api/v1/account/info',
        method: HttpMethod.get);
    return response.data['data'];
  }
}
