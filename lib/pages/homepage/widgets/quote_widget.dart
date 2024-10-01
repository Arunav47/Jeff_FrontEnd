import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/models/get_quote.dart';

class QuoteWidget extends StatelessWidget {
  final GetQuote quote;
  const QuoteWidget({
    required this.quote,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Text(quote.quote, style: const TextStyle(fontSize: 20),);
  }
}