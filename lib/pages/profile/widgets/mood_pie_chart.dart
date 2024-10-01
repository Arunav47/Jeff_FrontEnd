import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/models/mood_distribution_model.dart';

class MoodPieChart extends StatelessWidget {
  final MoodDistribution moodData;

  MoodPieChart({required this.moodData});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: moodData.anger,
            color: Colors.red,
            title: 'Anger',
            radius: 100,
          ),
          PieChartSectionData(
            value: moodData.happy,
            color: Colors.green,
            title: 'Happy',
            radius: 100,
          ),
          PieChartSectionData(
            value: moodData.fear,
            color: Colors.purple,
            title: 'Fear',
            radius: 100,
          ),
          PieChartSectionData(
            value: moodData.anxiety,
            color: Colors.blue,
            title: 'Anxiety',
            radius: 100,
          ),
          PieChartSectionData(
            value: moodData.sadness,
            color: Colors.grey,
            title: 'Sadness',
            radius: 100,
          ),
          PieChartSectionData(
            value: moodData.boredom,
            color: Colors.amber,
            title: 'Boredom',
            radius: 100,
          ),
          PieChartSectionData(
            value: moodData.excitement,
            color: Colors.orange,
            title: 'Excitement',
            radius: 100,
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
