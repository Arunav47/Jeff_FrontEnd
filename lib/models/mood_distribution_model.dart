class MoodDistribution {
  // final int totalEntities;
  final double anger;
  final double calm;
  final double happy;
  final double fear;
  final double anxiety;
  final double sadness;
  final double boredom;
  final double excitement;

  MoodDistribution({
    // required this.totalEntities,
    required this.anger,
    required this.calm,
    required this.happy,
    required this.fear,
    required this.anxiety,
    required this.sadness,
    required this.boredom,
    required this.excitement,
  });

  factory MoodDistribution.fromJson(Map<String, dynamic> json) {
    return MoodDistribution(
      // totalEntities: int.parse(json['totalEntities']),
      anger: double.parse(json['anger']),
      happy: double.parse(json['happy']),
      calm: double.parse(json['calm']),
      fear: double.parse(json['fear']),
      anxiety: double.parse(json['anxiety']),
      sadness: double.parse(json['sadness']),
      boredom: double.parse(json['boredom']),
      excitement: double.parse(json['excitement']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      // 'totalEntities' : totalEntities,
      'anger' : anger,
      'happy' : happy,
      'calm' : calm,
      'fear' : fear,
      'anxiety' : anxiety,
      'sadness' : sadness,
      'boredom' : boredom,
      'excitement' : excitement
    };
  }
}
