import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import 'package:know_ai_app/constant.dart';

import 'package:know_ai_app/ui/login/login_screen.dart';
import 'package:know_ai_app/ui/register/register_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ),
            );
          },
          child: Text(
              // "Login".toUpperCase(),
              'signInButton'.tr),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const RegisterScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor,
            elevation: 0,
          ),
          child: Text(
            // "Sign Up".toUpperCase(),
            'signUpButton'.tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
