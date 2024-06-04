import 'package:get/get.dart';
import 'package:know_ai_app/ui/home/home.dart';
import 'package:know_ai_app/ui/login/login_screen.dart';
import 'package:know_ai_app/ui/register/register_screen.dart';
import 'package:know_ai_app/ui/user/user_details.dart';
import 'package:know_ai_app/ui/user/user_setting.dart';
import 'package:know_ai_app/ui/welcome/welcome_screen.dart';

class Routers {
  static final routes = [
    GetPage(name: "/", page: () => const WelcomeScreen()),
    GetPage(name: "/login", page: () => const LoginScreen()),
    GetPage(name: "/register", page: () => const RegisterScreen()),
    GetPage(name: "/home", page: () => const Home()),
    GetPage(name: "/user", page: () => const UserDetails()),
    GetPage(name: "/setting", page: () => const UserSetting())
  ];
}
