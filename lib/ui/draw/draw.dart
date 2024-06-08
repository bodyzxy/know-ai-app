import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/component/button_widget.dart';
import 'package:know_ai_app/component/textfile.dart';

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<StatefulWidget> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  final isWaiting = false.obs;
  late final String write;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 70),
          TextFieldWidget(
            label: 'draw'.tr,
            text: 'input'.tr,
            enabled: true,
            onChanged: (value) {
              setState(() {
                write = value;
              });
            },
          ),
          const SizedBox(height: 24),
          sendDraw(),
          const SizedBox(height: 24),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 20,
            margin: const EdgeInsets.all(10),
          )
        ],
      ),
    );
  }

  Widget sendDraw() => ButtonWidget(text: 'send'.tr, onClicked: () async {});
}
