import 'package:get/get.dart';
import 'package:know_ai_app/api/user/user_information.dart';
import 'package:know_ai_app/model/user.dart';

class UserController extends GetxController {
  User getUserInformation() {
    late User user;
    Future<Map<String, dynamic>> data = UserInformation().userInformation();
    data.then((value) {
      String name = value['name'];
      String email = value['email'];

      user = User(name: name, email: email);
    });
    return user;
  }
}
