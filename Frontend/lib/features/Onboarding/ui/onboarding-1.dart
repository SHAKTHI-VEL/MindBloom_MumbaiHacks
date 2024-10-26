import 'package:flutter/material.dart';
import 'package:mindbloom/features/Onboarding/ui/onboarding-3.dart';
import 'package:mindbloom/features/SplashScreen/ui/splashScreen.dart';

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({
    super.key,
  });

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne> {
  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = TextEditingController();
    TextEditingController lastName = TextEditingController();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                Row(
                  children: [
                    Text(
                      "What's your name?",
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Let us know how to properly address you",
                      style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff525252)),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: TextField(
                        controller: firstName,
                        decoration: InputDecoration(
                          // label: Text('First Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "First Name",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: TextField(
                        controller: lastName,
                        decoration: InputDecoration(
                          // label: Text('First Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Last Name",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                      },
                      color: const Color(0xffDFE2E8),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                      shape: const CircleBorder(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: screenWidth * 0.07,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: const Color(0xff1E1E1E),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnboardingThree()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Next',
                          style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
