import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'signUpButton': 'Sign Up',
          'signInButton': 'Sign In',
          'email': 'Your email',
          'password': 'Your password',
          'confirmPassword': 'Confirm Password',
          'home.title': 'WELCOME TO EDU',
          'have.account': 'Already have an Account ?',
          'not.account': 'Don’t have an Account ?',
          'activation.title': 'activation',
          'activation.text':
              'Account registration is successful, please go to your email to activate',
          'activation.ready': 'Email is registered',
          'login.error': 'mistake',
          'user.name': 'Full Name',
          'name.error': 'Name is empty'
        },
        'zh': {
          'signUpButton': '注册',
          'signInButton': '登录',
          'email': '邮件',
          'password': '密码',
          'confirmPassword': '确认密码',
          'home.title': '欢迎来到EDU',
          'have.account': '已有账户?',
          'not.account': '没有账号?',
          'activation.title': '激活',
          'activation.text': '账户注册成功，请前往邮箱进行激活',
          'activation.ready': '邮箱已注册',
          'login.error': '错误',
          'user.name': '用户名',
          'name.error': '姓名为空'
        }
      };
}
