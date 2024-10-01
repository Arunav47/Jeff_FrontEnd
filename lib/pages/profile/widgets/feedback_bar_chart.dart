import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/models/feedback_percentage.dart';

class FeedbackBarChart extends StatelessWidget {
  final FeedbackPercentage feedbackData;

  FeedbackBarChart({required this.feedbackData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return Text('Better');
                  case 1:
                    return Text('Not Better');
                  default:
                    return Text('');
                }
              },
            ),
          )
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
              fromY: 0,
              toY: feedbackData.percentageBetter,
              color: Colors.blue,
              width: 30,
            )
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
              fromY: 0,
              toY: feedbackData.percentageNotBetter,
              color: Colors.red,
              width: 30,
            )
          ]),
        ],
      ),
    );
  }
}
