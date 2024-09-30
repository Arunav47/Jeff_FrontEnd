import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/pages/chatbot/feeling_assesment.dart';
import 'package:mental_health_support_chatbot/pages/homepage/home.dart';
import 'package:mental_health_support_chatbot/pages/journal/journal_list.dart';
import 'package:mental_health_support_chatbot/pages/profile/analytics.dart';
import 'package:mental_health_support_chatbot/pages/profile/profile.dart';
import 'package:mental_health_support_chatbot/services/gemini_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "/homepage";


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late String quote;
  GeminiServices geminiServices = GeminiServices();
  List<Widget> pages = [
    const Home(),
    const MoodAssessMent(),
    const JournalDetails(),
    const AnalyticsPage(),

  ];
  late int _index;
  @override
  void initState() async{
    _index = 0;
    super.initState();
  }
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
            icon: Icon(Icons.book),
            label: 'Journal',
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