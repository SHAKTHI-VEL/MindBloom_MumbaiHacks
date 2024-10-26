import 'package:flutter/material.dart';
import 'package:mindbloom/features/Analytics/widgets/moodBar.dart';
import 'package:mindbloom/features/Analytics/widgets/moodHistory.dart';
import 'package:mindbloom/features/Analytics/widgets/streakJournal.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  final List<bool> streakData = List.generate(31, (index) => index % 3 == 0);
  final List<String> moodData = ['😊', '😔', '😡', '😰', '😓'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Mood Analytics',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreakJournal(streakData: streakData),
              MoodHistory(weekDays: weekDays, moodData: moodData),
              MoodBar(moodData: moodData),
            ],
          ),
        ),
      ),
    );
  }
}
