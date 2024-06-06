import 'package:flutter/material.dart';

class KnowHubPage extends StatefulWidget {
  const KnowHubPage({super.key});

  @override
  State<StatefulWidget> createState() => _KnowHubPageState();

}

class _KnowHubPageState extends State<KnowHubPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("知识库页面"),
    );
  }

}