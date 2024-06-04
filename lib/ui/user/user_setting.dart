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
import 'package:know_ai_app/model/user.dart';
import 'package:know_ai_app/utils/token/token_storage.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  final user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'user.name'.tr,
            text: user.name,
            onChanged: (name) {
              setState(() {
                // user.name = name;
              });
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'email'.tr,
            text: user.email,
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
