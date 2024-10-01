import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  static String quote = "Hello";
  late String mood;
  GeminiServices geminiServices = GeminiServices();

  void getPreviousMood() async{
    try{
      final http.Response response = await http.post(
        Uri.parse("$baseUrl/Analytics/previous_mood"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          'userid': FirebaseAuth.instance.currentUser!.uid
        })
      );
      if(response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        setState(() {
          mood = responseBody["mood"];
        }); 
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
        setState(() {
          mood = "happy";
        });
      }
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
      setState(() {
        mood = "happy";
      });
    }
  }

  Future<void> getQuote() async{
    getPreviousMood();
    try{
      final http.Response response = await http.post(
        Uri.parse("$baseUrl/Gemini/mood"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          'mood': mood
        })
      );
      if(response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        setState(() {
          quote = responseBody["quote"];
        });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
        setState(() {
          quote = "Something went wrong";
        });
      }
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
      setState(() {
        quote = "Something went wrong";
      });
    }
  }

  late int _index;
  @override
  void initState(){
    _index = 0;
    super.initState();
  }
  List<Widget> pages = [
    Home(quote: quote,),
    const MoodAssessMent(),
    const JournalDetails(),
    const AnalyticsPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              backgroundColor: Color.fromARGB(255, 236, 82, 185)//Color(0xFFABC798),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'ChatBot',
              backgroundColor: Color.fromARGB(255, 236, 82, 185)//Color(0xFFABC798)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Journal',
              // backgroundColor: Color(0xFFABC798),
              backgroundColor: Color.fromARGB(255, 236, 82, 185)//Color(0xFFABC798),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              // backgroundColor: Color(0xFFABC798),
              backgroundColor: Color.fromARGB(255, 236, 82, 185)//Color(0xFFABC798),
            ),
          ],
        )
      ),
    );
  }
}