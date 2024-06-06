import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import 'package:know_ai_app/constant/constant.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed("/login");
          },
          child: Text(
              // "Login".toUpperCase(),
              'signInButton'.tr),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Get.toNamed("/register");
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
