import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mental_health_support_chatbot/pages/auth/login/login_page.dart';
import 'package:mental_health_support_chatbot/pages/auth/signup_page/sign_up_page.dart';
import 'package:mental_health_support_chatbot/pages/homepage/homepage.dart';
import 'package:mental_health_support_chatbot/pages/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/journal_provider.dart';
import 'utils/theme/theme.dart';

Future<void> main() async{
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String initialRoute;
    static final auth = FirebaseAuth.instance;
    final user  = auth.currentUser;
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async{
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => JournalProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: TrendyTheme.lightTheme, 
        darkTheme: TrendyTheme.darkTheme,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          HomePage.routeName: (context) => const HomePage(),
          SplashScreen.routeName: (context) => const SplashScreen(),
        },
        initialRoute: SplashScreen.routeName,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   void initState() {
//     super.initState();
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => JournalProvider(),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         themeMode: ThemeMode.system,
//         theme: TrendyTheme.lightTheme, 
//         darkTheme: TrendyTheme.darkTheme,
//         routes: {
//           LoginPage.routeName: (context) => const LoginPage(),
//           SignUpPage.routeName: (context) => const SignUpPage(),
//           HomePage.routeName: (context) => const HomePage(),
//           SplashScreen.routeName: (context) => const SplashScreen(),
//         },
//         initialRoute: SplashScreen.routeName,
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }

