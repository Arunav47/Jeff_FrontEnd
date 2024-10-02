import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_support_chatbot/models/get_quote.dart';
import 'package:mental_health_support_chatbot/pages/games/find_word_game/find_word_game.dart';

import '../../services/gemini_services.dart';

class Home extends StatefulWidget {
  final String quote;
  const Home({
    required this.quote,
    super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<GetQuote> quote;
  GeminiServices geminiServices = GeminiServices();
  String name = FirebaseAuth.instance.currentUser!.displayName!;
  @override
  void initState(){
    super.initState();
      quote = getQuote(FirebaseAuth.instance.currentUser!.uid);
  }


  Future<GetQuote> getQuote(String userId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/Gemini/mood"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userid': userId}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return GetQuote.fromJson(responseBody);
    } else {
      throw Exception('Failed to load quote');
    }
  }

  Widget getGreetings(){
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Text('Good Morning', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(width: 10,),
                Image(image: AssetImage('assets/images/summer.png'), height: 40, width: 40,)
              ],
            );
    } else if (hour < 17) {
      return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Text('Good Afternoon', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(width: 10,),
                Image(image: AssetImage('assets/images/daytime.png'), height: 40, width: 40,)
              ],
            );
    } else {
      return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Text('Good Evening', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(width: 10,),
                Image(image: AssetImage('assets/images/night.png'), height: 40, width: 40,)
              ],
            );
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(screenWidth*0.05),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text("Hello $name!", style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
              ),
              const SizedBox(height: 10,),
              getGreetings(),
              const SizedBox(height: 20,),
              Container(
                width: screenWidth*0.85,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF97CCEC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Today's Quote", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                FutureBuilder<GetQuote>(
                  future: quote, 
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Handle error here by showing a text message or snack bar
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Something went wrong!!")),
                        );
                      });
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!.quote,
                          style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return const Text('No quote available');
                    }
                  },
                ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                child: const Text("StressBuster Games", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
              const SizedBox(height: 10,),
              CarouselSlider(
                  items: [
                    InkWell(
                      child: Card(
                        color: Colors.indigoAccent,
                        elevation: 30,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 350,
                              child: Image(image: AssetImage('assets/images/puzzlegame1.jpg')),
                            ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WordPuzzle()));  
                      },
                    ),
                    InkWell(
                      child: Card(
                        elevation: 30,
                        color: Colors.indigoAccent,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 350,
                              child: Image(image: AssetImage('assets/images/puzzlegame2.jpg')),
      
                            ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WordPuzzle()));  
                      },
                    ),
                    InkWell(
                      child: Card(
                        color: Colors.indigoAccent,
                        elevation: 30,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 350,
                              child: Image(image: AssetImage('assets/images/puzzlegame1.jpg')),
      
                            ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WordPuzzle()));  
                      },
                    ),
                    InkWell(
                      child: Card(
                        color: Colors.indigoAccent,
                        elevation: 30,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 350,
                              child: Image(image: AssetImage('assets/images/puzzlegame2.jpg')),
      
                            ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WordPuzzle()));  
                      },
                    ),
                  ],
                  options: CarouselOptions(
                    // enlargeCenterPage: true,
                    viewportFraction: 1,
                    autoPlay: true,
                    clipBehavior: Clip.antiAlias,
                  )),
              const SizedBox(height: 10,),
              
              const SizedBox(height: 10,),
              // Text(quote, style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 10,),
            ],
          ),
        )
      ),
    );
  }
}