import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<StatefulWidget> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  final isWaiting = false.obs;
  @override
  Widget build(BuildContext context) {
    return Text("绘图");
  }
}
