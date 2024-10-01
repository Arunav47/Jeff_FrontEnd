class FeedbackPercentage {
  final double percentageBetter;
  final double percentageNotBetter;

  FeedbackPercentage({required this.percentageBetter, required this.percentageNotBetter});

  factory FeedbackPercentage.fromJson(Map<String, dynamic> json) {
    return FeedbackPercentage(
      percentageBetter: double.parse(json['percentage_better']),
      percentageNotBetter: double.parse(json['percentage_not_better']),
    );
  }
}
