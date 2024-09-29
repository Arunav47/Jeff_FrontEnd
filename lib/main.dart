import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/pages/auth/login/login_page.dart';
import 'package:mental_health_support_chatbot/pages/auth/signup_page/sign_up_page.dart';
import 'package:mental_health_support_chatbot/pages/homepage/homepage.dart';
import 'package:mental_health_support_chatbot/pages/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/journal_provider.dart';
import 'utils/theme/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

