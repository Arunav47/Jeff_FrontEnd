import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/feedback_percentage.dart';
import '../../models/mood_distribution_model.dart';
import 'widgets/feedback_bar_chart.dart';
import 'widgets/mood_pie_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  static String baseUrl = dotenv.env['BASE_URL']!;
  static String apiUrl = "$baseUrl/Analytics/";
  late Future<FeedbackPercentage> futureFeedbackPercentage;
  late Future<MoodDistribution> futureMoodDistribution;

  @override
  void initState() {
    super.initState();
    futureMoodDistribution = fetchMoodDistribution(FirebaseAuth.instance.currentUser!.uid);
    futureFeedbackPercentage = fetchFeedbackPercentage(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Text("User Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UserName',
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  controller: TextEditingController(text: FirebaseAuth.instance.currentUser!.displayName),
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  controller: TextEditingController(text: FirebaseAuth.instance.currentUser!.email),
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text("Mood Distribution", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          
              SizedBox(
                height: 400,
                child: FutureBuilder<MoodDistribution>(
                  future: futureMoodDistribution,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: MoodPieChart(moodData: snapshot.data!),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text("Feedback Percentage", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          
              SizedBox(height: 400,
                child: FutureBuilder<FeedbackPercentage>(
                  future: futureFeedbackPercentage,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: FeedbackBarChart(feedbackData: snapshot.data!),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<FeedbackPercentage> fetchFeedbackPercentage(String userId) async {
    final response = await http.post(
      Uri.parse('${apiUrl}feedback_percentage'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userid': userId}),
    );

    if (response.statusCode == 200) {
      return FeedbackPercentage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load feedback percentage');
    }
  }
  Future<MoodDistribution> fetchMoodDistribution(String userId) async {
    final response = await http.post(
      Uri.parse('${apiUrl}mood_distribution'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userid': userId}),
    );

    if (response.statusCode == 200) {
      return MoodDistribution.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load mood distribution');
    }
  }
}