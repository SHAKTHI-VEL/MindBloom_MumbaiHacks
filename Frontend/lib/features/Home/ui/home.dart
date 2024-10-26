import 'package:flutter/material.dart';
import 'package:mindbloom/features/Home/ui/chatScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff87A2FF),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: 250, // Increased size
                    height: 250, // Increased size
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle, // Made container circular
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      // Clip the image in circular shape
                      child: Image.asset(
                        'assets/Coco.png',
                        fit: BoxFit
                            .cover, // Changed to cover for better circular fitting
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff87A2FF),
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Chat with Coco',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Increased spacing
                    Text(
                      "We don't store your chats, they're deleted after each session",
                      style: TextStyle(
                        color: Colors
                            .grey[800], // Darker grey for better visibility
                        fontSize: 14, // Increased font size
                        fontWeight: FontWeight.w500, // Added medium weight
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
