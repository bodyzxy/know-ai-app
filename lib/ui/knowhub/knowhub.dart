import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/component/button_widget.dart';

class KnowHubPage extends StatefulWidget {
  const KnowHubPage({super.key});

  @override
  State<StatefulWidget> createState() => _KnowHubPageState();
}

class _KnowHubPageState extends State<KnowHubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 70),
          uploadFile(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget uploadFile() => ButtonWidget(
        text: 'uploadFile'.tr,
        onClicked: () {},
      );
}
