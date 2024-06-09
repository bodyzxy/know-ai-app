import 'package:dio/dio.dart';

import 'package:file_picker/file_picker.dart';
import 'package:know_ai_app/api/user.dart';
import 'package:know_ai_app/config/request.dart';
import 'package:know_ai_app/storage/token_storage.dart';

class FileApi {
  var tokenStorage = TokenStorage();

  Future<Map<String, String>> uploadFile() async {
    String accessToken = await tokenStorage.getAccessToken();
    var dio = CustomizeDio.instance.getDio(token: accessToken);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      List<MultipartFile> files = [];
      result.files.forEach((file) {
        MultipartFile multipartFile =
            MultipartFile.fromBytes(file.bytes!, filename: file.name);
        files.add(multipartFile);
      });
      int userId = 1;
      FormData data = FormData.fromMap({'files': files, "userId": userId});
      Map<String, dynamic>? user = await UserApi().getUserInfo();
      dynamic userData = user?['data'];

      // 检查userId是否为null
      try {
        var rsp = await dio.post(ApiUrl.upload, data: data);
        return rsp.data;
      } catch (e) {
        return {"code": "4001", "message": e.toString(), "data": e.toString()};
      }
    } else {
      // 处理result为null的情况，这里可以返回一个错误状态或者抛出异常
      return {
        "code": "4003",
        "message": "FilePickerResult is null",
        "data": ""
      };
    }
  }
}
