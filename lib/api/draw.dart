import 'package:know_ai_app/config/request.dart';
import 'package:know_ai_app/model/dto/draw.dart';

import '../storage/token_storage.dart';

class DrawApi {
  var tokenStorage = TokenStorage();
  Future<List<dynamic>> draw(String prompt, DrawOption options) async {
    String accessToken = await tokenStorage.getAccessToken();
    var dio = CustomizeDio.instance.getDio(token: accessToken);
    var rsp = await dio.post(ApiUrl.draw,
        data: {"prompt": prompt, "options": options.toJson()});
    return rsp.data['data'];
  }
}
