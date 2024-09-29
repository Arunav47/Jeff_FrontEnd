import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/services/gemini_services.dart';

class EndMood extends StatefulWidget {
  final String mood;
  const EndMood({
    required this.mood,
    super.key});

  @override
  State<EndMood> createState() => _EndMoodState();
}

class _EndMoodState extends State<EndMood> {

  GeminiServices geminiServices = GeminiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Are You Feeling Better?"),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () async{
            geminiServices.sendMood(context, widget.mood, true);
          }, child: const Text("Yes")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            geminiServices.sendMood(context, widget.mood, false);
          }, child: const Text("No"))
        ],
      ),
    );
  }
}