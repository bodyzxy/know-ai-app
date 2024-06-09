import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/component/button_widget.dart';
import 'package:know_ai_app/component/profile_widget.dart';
import 'package:know_ai_app/component/textfile.dart';
import 'package:know_ai_app/controller/user_controller.dart';
import 'package:know_ai_app/storage/token_storage.dart';

import '../../constant/constant.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  final _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "设置中心",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:
                'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'user.name'.tr,
            text: _userController.getCurrUser().name,
            enabled: false,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'email'.tr,
            text: _userController.getCurrUser().email,
            enabled: false,
            onChanged: (email) {
              setState(() {
                // user.email = email;
              });
            },
          ),
          const SizedBox(height: 24),
          buildUpgradeButton(),
          const SizedBox(height: 24),
          deleteButton()
        ],
      ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: '保存',
        onClicked: () {
          if (_userController.getCurrUser().name.isNotEmpty) {
            Get.back();
          } else {
            Get.defaultDialog(
                title: 'login.error'.tr, content: Text('name.error'.tr));
          }
        },
      );

  Widget deleteButton() => ButtonWidget(
        text: '退出',
        onClicked: () async {
          await TokenStorage().deleteAllTokens();
          final accessToken = await TokenStorage().getAccessToken();
          if (kDebugMode) {
            print("-=-=-=-=-=-=-=-= ${accessToken}");
          }
          await Get.offAllNamed("/");
        },
      );
}
