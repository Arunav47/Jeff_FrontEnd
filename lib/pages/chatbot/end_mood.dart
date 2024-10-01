import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/pages/homepage/home.dart';
import 'package:mental_health_support_chatbot/pages/homepage/homepage.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(screenWidth*0.08),
          width: screenWidth,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Are You Feeling Better?", style: TextStyle(fontSize: 25),),
              SizedBox(height: screenHeight*0.1,),
              ElevatedButton(onPressed: () async{
                geminiServices.sendMood(context, widget.mood, true);
                Navigator.popUntil(context, ModalRoute.withName('/homepage'));
                }, child: const Text("Yes"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minimumSize: Size(150, 50)),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                  geminiServices.sendMood(context, widget.mood, false);
                  Navigator.popUntil(context, ModalRoute.withName('/homepage'));
                }, child: const Text("No"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minimumSize: Size(150, 50)),
              )
            ],
          ),
        ),
      ),
    );
  }
}