class MoodDistribution {
  final double anger;
  final double happy;
  final double fear;
  final double anxiety;
  final double sadness;
  final double boredom;
  final double excitement;

  MoodDistribution({
    required this.anger,
    required this.happy,
    required this.fear,
    required this.anxiety,
    required this.sadness,
    required this.boredom,
    required this.excitement,
  });

  factory MoodDistribution.fromJson(Map<String, dynamic> json) {
    return MoodDistribution(
      anger: double.parse(json['anger']),
      happy: double.parse(json['happy']),
      fear: double.parse(json['fear']),
      anxiety: double.parse(json['anxiety']),
      sadness: double.parse(json['sadness']),
      boredom: double.parse(json['boredom']),
      excitement: double.parse(json['excitement']),
    );
  }
}
