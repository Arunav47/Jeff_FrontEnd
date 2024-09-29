import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {

  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user  = auth.currentUser;
    Timer(const Duration(seconds: 3), 
      ()=> Navigator.popAndPushNamed(context, user == null ? '/loginPage' : '/homepage')  
    );
  }
}