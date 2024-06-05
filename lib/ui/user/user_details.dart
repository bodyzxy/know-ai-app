import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:know_ai_app/component/build_app_bar.dart';
import 'package:know_ai_app/component/button_widget.dart';
import 'package:know_ai_app/component/numbers_widget.dart';
import 'package:know_ai_app/component/profile_widget.dart';
import 'package:know_ai_app/controller/user/user_controller.dart';
import 'package:know_ai_app/model/user.dart';
import 'package:know_ai_app/model/preference/user_preferences.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  User user = UserController().getUserInformation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:
                'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
            onClicked: () async {
              Get.toNamed("/setting");
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          const NumbersWidget(),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );
  Widget buildUpgradeButton() => ButtonWidget(
        text: '设置',
        onClicked: () {
          Get.toNamed("/setting");
        },
      );
}
