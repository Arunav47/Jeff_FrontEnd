import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/gemini_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String quote;
  GeminiServices geminiServices = GeminiServices();
  String name = FirebaseAuth.instance.currentUser!.displayName!;
  @override
  void initState() async{
    quote = await geminiServices.getQuote(context, FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Hello $name!", style: const TextStyle(fontSize: 30),),
          SizedBox(height: 10,),
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
                        child: Image.asset(
                          "assets/image/clothing.jpg",
                        )),
                  ),
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
                        child: Image.asset("assets/image/furniture.jpeg")),
                  ),
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
                        child: Image.asset(
                          "assets/image/appliances.jpeg",
                        )),
                  ),
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
                        child: Image.asset(
                          "assets/image/gadgets.jpeg",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
              options: CarouselOptions(
                // enlargeCenterPage: true,
                viewportFraction: 1,
                autoPlay: true,
                clipBehavior: Clip.antiAlias,
              )),
          SizedBox(height: 10,),
          Text(quote),
        ],
      )
    );
  }
}