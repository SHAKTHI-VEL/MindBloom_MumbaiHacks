import 'package:flutter/material.dart';

class MoodHistory extends StatelessWidget {
  final List<String> weekDays;
  final List<String> moodData;

  const MoodHistory({
    super.key,
    required this.weekDays,
    required this.moodData,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Text(
              'Mood History',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  width: screenWidth * 0.15,
                  margin: EdgeInsets.only(right: screenWidth * 0.02),
                  child: Column(
                    children: [
                      Text(
                        moodData[index % 5],
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        weekDays[index],
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}
