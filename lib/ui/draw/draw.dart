import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/component/build_app_bar.dart';

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<StatefulWidget> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  final isWaiting = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("sssssss"),
      // ),
      appBar: AppBar(
        title: Text('draw'.tr),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Get.toNamed("/setting");
              },
              child: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          ),
        ],
        leading: buildAppBar(context),
      ),
      body: const Column(
        children: [SizedBox(height: 5)],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
        child: TextField(
          cursorColor: Colors.blue,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              filled: true,
              hintText: 'input'.tr,
              suffixIcon: Obx(() => isWaiting.value
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : GestureDetector(
                      onTap: () async {},
                      child: const Icon(
                        Icons.send,
                        size: 30,
                      )))),
        ),
      ),
    );
  }
}
