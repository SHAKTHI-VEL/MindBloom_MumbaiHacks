// widgets/mood_bar.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodBar extends StatelessWidget {
  final List<String> moodData;

  const MoodBar({
    super.key,
    required this.moodData,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.35,
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.04,
          screenWidth * 0.04,
          screenWidth * 0.04,
          screenWidth * 0.08,
        ),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100, // Changed to 100 for percentage
            minY: 0,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '${rod.toY.toStringAsFixed(1)}%',
                    TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.035,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: screenWidth * 0.13,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.01),
                      child: Text(
                        moodData[value.toInt() % 5],
                        style: TextStyle(fontSize: screenWidth * 0.07),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: screenWidth * 0.1,
                  interval: 20,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}%',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey.shade600,
                      ),
                    );
                  },
                ),
              ),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 20,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade200,
                  strokeWidth: 1,
                );
              },
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 45,
                    color: const Color(0xFFFFB300),
                    width: screenWidth * 0.06,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  )
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 20,
                    color: const Color(0xFF64B5F6),
                    width: screenWidth * 0.06,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  )
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 10,
                    color: const Color(0xFFE57373),
                    width: screenWidth * 0.06,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  )
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: 10,
                    color: const Color(0xFFBA68C8),
                    width: screenWidth * 0.06,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  )
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    toY: 15,
                    color: const Color(0xFF81C784),
                    width: screenWidth * 0.06,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
