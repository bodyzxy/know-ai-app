import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:know_ai_app/api/user.dart';

import 'package:know_ai_app/constant/constant.dart';

import 'package:know_ai_app/component/account_check.dart';
import 'package:know_ai_app/storage/token_storage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: 'email'.tr,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: 'password'.tr,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              //验证表单
              if (_formKey.currentState!.validate()) {
                //提交表单
                _formKey.currentState!.save();

                final jsonData = {
                  'email': _emailController.text,
                  'password': _passwordController.text
                };

                Map<String, dynamic> rsp = await UserApi().login(jsonData.cast<String,dynamic>());
                if (rsp['code'] == 0) {
                  Get.offAllNamed("/home");
                } else {
                  Get.defaultDialog(
                      title: 'login.error'.tr,
                      content: Text(rsp['message']));
                  Get.offAllNamed("/login");
                }
              }
            },
            child: Text(
                // "Login".toUpperCase(),
                'signInButton'.tr),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Get.toNamed("/register");
            },
          ),
        ],
      ),
    );
  }
}
