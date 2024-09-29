import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/gemini_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String quote;
  GeminiServices geminiServices = GeminiServices();
  @override
  void initState() async{
    quote = await geminiServices.getQuote(context, FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}