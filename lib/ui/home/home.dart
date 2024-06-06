import 'package:flutter/material.dart';
import 'package:know_ai_app/ui/draw/draw.dart';
import 'package:know_ai_app/ui/knowhub/knowhub.dart';
import 'package:know_ai_app/ui/user/user_details.dart';
import 'package:know_ai_app/ui/chat/chat.dart';

import '../../constant/constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.chat_bubble_outline,
          size: 30,
        ),
        backgroundColor: kPrimaryColor,
        label: "对话"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.draw,
          size: 30,
        ),
        backgroundColor: kPrimaryColor,
        label: "绘画"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.file_open_rounded,
          size: 30,
        ),
        backgroundColor: kPrimaryColor,
        label: "知识库"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          size: 30,
        ),
        backgroundColor: kPrimaryColor,
        label: "我的")
  ];

  final List<Widget> _bottomNavigationBarPage = [
    const ChatPage(),
    const DrawPage(),
    const KnowHubPage(),
    const UserDetails()
  ];

  int _currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavigationBarPage[_currIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        items: _bottomNavigationBarItems,
        currentIndex: _currIndex,
        onTap: onTapChanged,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blueAccent,
      ),
    );
  }

  void onTapChanged(int value) {
    setState(() {
      _currIndex = value;
    });
  }
}
