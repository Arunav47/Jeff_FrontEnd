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
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            child: const Image(image: AssetImage("assets/images/logo.png")),
          )
        ),
      ),
    );
  }
}