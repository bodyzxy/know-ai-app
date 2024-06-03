import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff937DFF),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              barItem(curPage == 0, 0, icon: Icons.home_filled, text: "对话"),
              barItem(curPage == 1, 1, icon: Icons.access_alarm, text: "绘图"),
              const SizedBox(
                width: 48,
              ),
              barItem(curPage == 2, 2, icon: Icons.message_sharp, text: "知识库"),
              barItem(curPage == 3, 3, icon: Icons.person, text: "我的"),
            ],
          ),
        ),
      ),
    );
  }

  IconButton barItem(
    bool active,
    int initPage, {
    required IconData icon,
    required String text,
  }) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      color: active ? const Color(0xff937DFF) : const Color(0xff949494),
      icon: Column(
        children: [
          Icon(icon),
          Text(
            text,
            style: TextStyle(
              color: active ? const Color(0xff937DFF) : const Color(0xff949494),
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}