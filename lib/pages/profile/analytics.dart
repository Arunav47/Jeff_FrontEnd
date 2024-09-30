import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  bool isLoading = true;
  double feedbackPercentage = 0;
  Map<String, dynamic>? moodData;

  static String _baseUrl = dotenv.env['BASE_URL']!;
  final String fetchMoodApiUrl = '$_baseUrl/Analytics/mood_distribution';
  final String fetchFeedbackPercentageApiUrl = '$_baseUrl/Analytics/feedback_percentage';
  @override
  void initState() {
    super.initState();
    fetchMoodData();
    fetchFeedbackPercentage();
  }

  Future<void> fetchMoodData() async {
    final response = await http.post(
      Uri.parse(fetchMoodApiUrl),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({"userid": FirebaseAuth.instance.currentUser!.uid}), // replace with actual user id
    );

    if (response.statusCode == 200) {
      setState(() {
        moodData = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load mood data');
    }
  }

  Future<void> fetchFeedbackPercentage() async {
    final response = await http.post(
      Uri.parse(fetchFeedbackPercentageApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userid': FirebaseAuth.instance.currentUser!.uid, // Replace with actual user ID
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        feedbackPercentage = double.parse(data['percentage'].toString());
      });
    } else {
      // Handle error
      print('Failed to load feedback percentage');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: isLoading
                ? const CircularProgressIndicator()
                : moodData != null
                ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PieChart(
                    PieChartData(
                      sections: showingSections(),
                      borderData: FlBorderData(show: false),
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                    ),
                  ),
                )
              : const Text('No data available'),
            ),
            Container(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: feedbackPercentage == 0
                ? Center(child: CircularProgressIndicator())
                : BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      maxY: 100, // Since percentage can't exceed 100
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: feedbackPercentage,
                              color: Colors.blue,
                              width: 40,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text('Feeling Better');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text('${value.toInt()}%');
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.red,
        value: double.parse(moodData!['anger'].toString()),
        title: '${moodData!['anger'].toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: double.parse(moodData!['happy'].toString()),
        title: '${moodData!['happy'].toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: double.parse(moodData!['fear'].toString()),
        title: '${moodData!['fear'].toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: double.parse(moodData!['anxiety'].toString()),
        title: '${moodData!['anxiety'].toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: double.parse(moodData!['sadness'].toString()),
        title: '${moodData!['sadness'].toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: double.parse(moodData!['boredom'].toString()),
        title: '${moodData!['boredom'].toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.pink,
        value: double.parse(moodData!['excitement'].toString()),
        title: '${moodData!['excitement'].toStringAsFixed(2)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}