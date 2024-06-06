import 'package:flutter/material.dart';
import 'package:know_ai_app/ui/draw/draw.dart';
import 'package:know_ai_app/ui/knowhub/knowhub.dart';
import 'package:know_ai_app/ui/user/user_details.dart';

import '../../constant/constant.dart';
import '../chat/chat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_outline,size: 30,),
        backgroundColor: Colors.blueAccent,
        label: "对话"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.draw,size: 30,),
        backgroundColor: Colors.blueAccent,
        label: "听故事"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.file_open_rounded,size: 30,),
        backgroundColor: Colors.blueAccent,

        label: "知识库"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.person,size: 30,),
        backgroundColor: Colors.blueAccent,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff937DFF),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: _bottomNavigationBarPage[_currIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        items: _bottomNavigationBarItems,
        currentIndex: _currIndex,
        onTap: onTapChanged,
        backgroundColor: Colors.blueAccent,
        fixedColor: Colors.blueAccent,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedLabelStyle: TextStyle(color: Colors.black),
        showUnselectedLabels: true,
      ),
    );
  }

  void onTapChanged(int value) {
    setState(() {
      _currIndex = value;
    });
  }


}
