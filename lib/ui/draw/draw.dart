import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/api/draw.dart';
import 'package:know_ai_app/component/button_widget.dart';
import 'package:know_ai_app/component/textfile.dart';
import 'package:know_ai_app/controller/draw_controller.dart';

import '../../model/dto/draw.dart';

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<StatefulWidget> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  final controller = Get.find<DrawController>();
  final isWaiting = false.obs;
  late String write = '';

  var drawOptions = DrawOption("dall-e-2", 256, 256, "url");
  var draw = DrawApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DrawController>(
      builder: (context) => ListView(
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
          ElevatedButton(
            onPressed: () async {
              List<dynamic> data = await draw.draw(write, drawOptions);
              if (data.isNotEmpty) {
                // 遍历data列表
                for (var element in data) {
                  // 访问每个元素的output字段
                  var output = element['output'];
                  // 获取output字段中的url字段的值
                  var imageUrl = output['url'];
                  controller.updateUrl(imageUrl);
                }
              }
            },
            child: const Text('发送'),
          ),
          const SizedBox(height: 24),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 20,
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                controller.url.value,
                // fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
