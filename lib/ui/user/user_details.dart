import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/component/button_widget.dart';
import 'package:know_ai_app/component/numbers_widget.dart';
import 'package:know_ai_app/component/profile_widget.dart';
import 'package:know_ai_app/controller/user_controller.dart';
import 'package:know_ai_app/model/user.dart';

import '../../constant/constant.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(_userController.isRead.value){
      _userController.getUserInformation();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text(
            "我的",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<UserController>(
          builder: (context) => !_userController.isRead.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: 10,),
                    ProfileWidget(
                      imagePath:
                          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                      onClicked: () async {
                        Get.toNamed("/setting");
                      },
                    ),
                    const SizedBox(height: 24),
                    buildName(_userController.getCurrUser()),
                    const SizedBox(height: 24),
                    Center(child: buildUpgradeButton()),
                    const SizedBox(height: 24),
                    const NumbersWidget(),
                  ],
                ),
        ));
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
