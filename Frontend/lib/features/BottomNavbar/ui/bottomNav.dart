import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindbloom/features/Activities/ui/activities.dart';
import 'package:mindbloom/features/Analytics/ui/analytics.dart';
import 'package:mindbloom/features/Home/ui/chatScreen.dart';
import 'package:mindbloom/features/Home/ui/home.dart';
import 'package:mindbloom/features/Profile/ui/profile.dart';
import 'package:mindbloom/features/Therapist/ui/therapist.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = [
    const Analytics(),
    const Home(),
    const Activities(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCenterButtonTapped() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xff87A2FF),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.chart_bar_alt_fill,
                  size: screenWidth * 0.06,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(width: 40),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.bolt,
                  size: screenWidth * 0.06,
                ),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          Positioned(
            bottom: screenHeight * 0.037,
            child: _buildCenterButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: _onCenterButtonTapped,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xff87A2FF),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: const Icon(
          CupertinoIcons.home,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
