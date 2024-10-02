class FeedbackPercentage {
  // final int totalEntities;
  final double percentageBetter;
  final double percentageNotBetter;

  FeedbackPercentage({
    // required this.totalEntities, 
    required this.percentageBetter, 
    required this.percentageNotBetter});

  factory FeedbackPercentage.fromJson(Map<String, dynamic> json) {
    return FeedbackPercentage(
      // totalEntities: int.parse(json['total_entities']),
      percentageBetter: double.parse(json['percentage_better']),
      percentageNotBetter: double.parse(json['percentage_not_better']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      // 'totalEntities' : totalEntities,
      'percentageBetter' : percentageBetter,
      'percentageNotBetter' : percentageNotBetter
    };
  }
}
