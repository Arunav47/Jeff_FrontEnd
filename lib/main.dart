import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/auth/login/login_page.dart';
import 'package:mental_health_support_chatbot/chatbot/chatbot_chat.dart';
import 'package:mental_health_support_chatbot/games/find_word_game/find_word_game.dart';
import 'package:mental_health_support_chatbot/homepage/homepage.dart';
import 'package:mental_health_support_chatbot/mood_analysis/mood_analysis.dart';
import 'utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: TrendyTheme.lightTheme, 
      darkTheme: TrendyTheme.darkTheme,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

