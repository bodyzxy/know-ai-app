import 'package:get/get.dart';
import 'package:know_ai_app/api/user/user_information.dart';
import 'package:know_ai_app/model/user.dart';

class UserController extends GetxController {
  User getUserInformation() {
    Future<Map<String, dynamic>> data = UserInformation().userInformation();
    data.then((value) {
      if (value['code'] == 403) {
        print("-=-=-=-==-=-=-=-=-=-=$value");
        return User(name: '', email: '');
      }
      String name = value['name'];
      String email = value['email'];

      return User(name: name, email: email);
    });
    return User(name: '', email: '');
  }
}
