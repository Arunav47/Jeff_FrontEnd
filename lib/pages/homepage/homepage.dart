import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/pages/chatbot/chatbot_chat.dart';
import 'package:mental_health_support_chatbot/pages/homepage/home.dart';
import 'package:mental_health_support_chatbot/pages/profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "/homepage";


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> pages = [
    const Home(),
    const ChatPage(),
    const ProfilePage()
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'ChatBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )
    );
  }
}