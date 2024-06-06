import 'package:flutter/material.dart';

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<StatefulWidget> createState() => _DrawPageState();

}

class _DrawPageState extends State<DrawPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("绘图页面"),
    );
  }

}