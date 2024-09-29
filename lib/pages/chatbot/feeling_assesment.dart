import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/pages/chatbot/chatbot_chat.dart';

class MoodAssessMent extends StatefulWidget {
  const MoodAssessMent({super.key});

  @override
  State<MoodAssessMent> createState() => _MoodAssessMentState();
}

class _MoodAssessMentState extends State<MoodAssessMent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood Assessment"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "How are you feeling today?",
            style: TextStyle(
                fontSize: 30
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "happy",)));
              }, child: Text("Happy")),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "calm",)));
              }, child: Text("Calm")),
            ],
          ),
          SizedBox(height: 10,),
          
          Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "excitement",)));
              }, child: Text("Excitement")),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "boredom",)));
              }, child: Text("Boredom")),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "anxiety",)));
              }, child: Text("Anxiety")),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "sadness",)));
              }, child: Text("Sadness")),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "fear",)));
              }, child: Text("Fear")),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(mood: "anger",)));
              }, child: Text("Anger")),
            ],
          ),
        ],
      )

    );
  }
}