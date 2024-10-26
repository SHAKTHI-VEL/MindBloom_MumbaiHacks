import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindbloom/features/Activities/ui/activities.dart';
import 'package:mindbloom/features/Analytics/ui/analytics.dart';
import 'package:mindbloom/features/BottomNavbar/ui/bottomNav.dart';
import 'package:mindbloom/features/Home/ui/chatScreen.dart';
import 'package:mindbloom/features/Login/ui/login.dart';
import 'package:mindbloom/features/Onboarding/ui/onboarding-1.dart';
import 'package:mindbloom/features/Signup/ui/signup.dart';
import 'package:mindbloom/features/SplashScreen/ui/splashScreen.dart';
import 'package:mindbloom/firebase_options.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xffFAFAFA)),
      debugShowCheckedModeBanner: false,
      initialRoute: 'signup',
      routes: {
        'home': (context) => Navbar(),
        'login': (context) => Login(),
        'signup': (context) => Signup(),
        'splash': (context) => SplashScreen(),
        'analytics': (context) => Analytics(),
        '/breathing': (context) => const BreathingScreen(),
        '/quotes': (context) => const QuotesScreen(),
        'onboarding': (context) => OnboardingOne(),
      },
      home: Navbar(),
    ),
  );
}
