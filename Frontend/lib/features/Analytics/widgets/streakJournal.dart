import 'package:flutter/material.dart';

class StreakJournal extends StatelessWidget {
  final List<bool> streakData;

  const StreakJournal({
    super.key,
    required this.streakData,
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
              'Streak Journal',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: screenWidth * 0.02,
                mainAxisSpacing: screenWidth * 0.02,
              ),
              itemCount: 31,
              itemBuilder: (context, index) {
                final bool hasStreak = streakData[index];
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hasStreak
                        ? const Color(0xFFFFE082)
                        : Colors.grey.shade200,
                  ),
                  child: hasStreak
                      ? Center(
                          child: Icon(
                            Icons.local_fire_department,
                            color: Colors.deepOrange,
                            size: screenWidth * 0.04,
                          ),
                        )
                      : null,
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
