import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
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
              image: AssetImage('assets/Text.png'),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Text(
              'Write down!',
              style: TextStyle(
                  fontSize: screenWidth * 0.075, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
