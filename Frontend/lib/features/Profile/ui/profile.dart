import 'package:flutter/material.dart';
import 'package:mindbloom/features/BottomNavbar/ui/bottomNav.dart';
import 'package:mindbloom/features/Home/ui/chatScreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Navbar()),
            );
          },
        ),
        title: Text('Profile',
            style: TextStyle(
                fontSize: screenWidth * 27 / 432, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: screenWidth * (95 / 432),
                child: ClipOval(
                  child: Image.asset(
                    'assets/profile.png',
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sidessh More',
                  style: TextStyle(
                      fontSize: screenWidth * 36 / 432,
                      fontWeight: FontWeight.w600))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('mosiddhesh@gmail.com',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey[600],
                      fontSize: screenWidth * 18 / 432,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]))
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
        ],
      )),
    );
  }
}
