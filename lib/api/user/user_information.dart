import 'package:know_ai_app/model/response/base_response.dart';
import 'package:know_ai_app/utils/method/http_method.dart';
import 'package:know_ai_app/utils/network_manager.dart';

class UserInformation {
  Future<Map<String, dynamic>> userInformation() async {
    NetworkManager networkManager = NetworkManager();

    networkManager.initialize();

    BaseResponse response = await networkManager.request('/api/v1/account/info',
        method: HttpMethod.get);
    return response.data['data'];
  }
}
