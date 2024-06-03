import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:know_ai_app/constant.dart';
import 'package:know_ai_app/component/account_check.dart';
import 'package:know_ai_app/controller/http_controller.dart';
import 'package:know_ai_app/ui/login/login_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _confirmPasswordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: 'confirmPassword'.tr,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();
                final jsonData = {
                  'email': _emailController.text,
                  'password': _passwordController.text,
                  'confirmPassword': _confirmPasswordController.text
                };
                HttpController().registerRequest(jsonData);
                Get.back();
              }
            },
            child: Text('signUpButton'.tr),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Get.toNamed("/login");
            },
          ),
        ],
      ),
    );
  }
}
