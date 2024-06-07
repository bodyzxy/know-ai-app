import 'package:get/get.dart';
import 'package:know_ai_app/api/user.dart';
import 'package:know_ai_app/model/user.dart';

class UserController extends GetxController {

  final _userApi = UserApi();

  late User _currUser;

  var isRead = false.obs;


  @override
  void onInit() async {
    _currUser = await getUserInformation();
    super.onInit();
    isRead(true);
    update();
  }

  Future<User> getUserInformation() async {
    Map<String, dynamic> data = await _userApi.getUserInfo();
    String name = "用户";
    String email = data['email'] ?? "未知邮箱";
    var user = User(name: name, email: email);
    return user;
  }

  User getCurrUser(){

    return _currUser;
  }
}
