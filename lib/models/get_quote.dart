class GetQuote {
  final String quote;

  GetQuote({required this.quote});

  factory GetQuote.fromJson(Map<String, dynamic> json) {
    return GetQuote(
      quote: json['reply'],
    );
  }
}
