import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:know_ai_app/model/hive_box.dart';
import 'package:know_ai_app/model/message.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<HistoryMessage>(historyBox).listenable(),
      builder: (context, Box<HistoryMessage> box, _) {
        if (box.values.isEmpty) {
          return const Center(
            child: Text(
              "无数据",
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          );
        }
        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            HistoryMessage? currentContext = box.getAt(index);
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onLongPress: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("你确定要删除 ${currentContext!.title}吗?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("No"),
                              onPressed: () => Get.back(),
                            ),
                            TextButton(
                              child: const Text("Yes"),
                              onPressed: () async {
                                await box.deleteAt(index);
                                Get.back();
                              },
                            )
                          ],
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 5),
                      Text(currentContext!.createTime.toString()),
                      const SizedBox(height: 5),
                      Text(currentContext!.title.length > 20
                          ? '${currentContext.title.substring(0, 20)}....'
                          : currentContext.title),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
