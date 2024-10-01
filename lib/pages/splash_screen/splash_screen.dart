import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/pages/splash_screen/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/splashPage";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  SplashServices services = SplashServices();
  
  @override
  void initState() {
    super.initState();
    services.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/images/logo.jpeg"),
          )
        ),
      ),
    );
  }
}