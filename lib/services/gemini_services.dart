import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


String baseUrl = dotenv.env['BASE_URL']!;


class GeminiServices{
  Future<void> sendMood(BuildContext context, String mood, bool feelingBetter) async {
      try {
        final http.Response response = await http.post(
          Uri.parse("$baseUrl/Analytics/add"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode({
            'id': DateTime.now().microsecondsSinceEpoch.toString(),
            'userid': FirebaseAuth.instance.currentUser!.uid,
            'mood': mood,
            'feeling_better': feelingBetter
          }),
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
      }
  }

  Future<String> getPreviousMood(BuildContext context, String userId) async{
    try{
      final http.Response response = await http.post(
        Uri.parse("$baseUrl/Analytics/previous_mood"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          'userid': userId
        })
      );
      if(response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        return responseBody["mood"];
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
        return "Something went wrong";
      }
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
      return "Something went wrong";
    }
  }
  
  Future<String> getQuote(BuildContext context, String userId) async{
    String mood = await getPreviousMood(context, userId);
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
        return responseBody["quote"];
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
        return "Something went wrong";
      }
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!!")));
      return "Something went wrong";
    }
  }
}