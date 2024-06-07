import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:know_ai_app/component/build_app_bar.dart';
import 'package:know_ai_app/component/button_widget.dart';
import 'package:know_ai_app/component/profile_widget.dart';
import 'package:know_ai_app/component/textfile.dart';
import 'package:know_ai_app/model/preference/user_preferences.dart';
import 'package:know_ai_app/controller/user/user_controller.dart';
import 'package:know_ai_app/model/user.dart';
import 'package:know_ai_app/storage/token_storage.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  User user = UserController().getUserInformation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
            text: user.name,
            enabled: false,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'email'.tr,
            text: user.email,
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
          if (user.name != null) {
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
