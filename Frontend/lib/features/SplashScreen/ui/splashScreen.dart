import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mindbloom/features/BottomNavbar/ui/bottomNav.dart';
import 'package:mindbloom/features/Login/ui/login.dart';
import 'package:mindbloom/features/Onboarding/ui/onboarding-1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _rotationAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      _controller.reverse().then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingOne()),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.7),
          end: FractionalOffset(0.0, 1),
          colors: [
            Color(0xff87A2FF),
            Color(0xFFDDD4C2),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Transform.rotate(
                          angle: _rotationAnimation.value * 6.28319,
                          child: child,
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/Logo.png',
                      height: screenHeight * 0.45,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                'Mind Bloom',
                style: TextStyle(
                    fontSize: screenWidth * 0.13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              SizedBox(
                width: screenWidth * (351 / 432),
                child: Text(
                  textAlign: TextAlign.center,
                  'Your personal space!',
                  style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
