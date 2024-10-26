import 'package:flutter/material.dart';

class MicInput extends StatefulWidget {
  const MicInput({super.key});

  @override
  State<MicInput> createState() => _MicInputState();
}

class _MicInputState extends State<MicInput> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xff000000), width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              fit: BoxFit.fill,
              width: screenWidth * 0.3,
              height: screenHeight * 0.12,
              image: AssetImage('assets/Radio.png'),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Text(
              'Speak Up!',
              style: TextStyle(
                  fontSize: screenWidth * 0.075, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
