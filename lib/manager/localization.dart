import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'signUpButton': 'Sign Up',
          'signInButton': 'Sign In',
          'email': 'Your email',
          'password': 'Your password',
          'home.title': 'WELCOME TO EDU',
          'have.account': 'Already have an Account ?',
          'not.account': 'Don’t have an Account ?',
        },
        'zh': {
          'signUpButton': '注册',
          'signInButton': '登录',
          'email': '邮件',
          'password': '密码',
          'home.title': '欢迎来到EDU',
          'have.account': '已有账户?',
          'not.account': '没有账号?',
        }
      };
}
