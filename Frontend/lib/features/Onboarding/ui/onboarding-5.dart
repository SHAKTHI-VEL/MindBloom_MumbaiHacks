import 'package:flutter/material.dart';
import 'package:mindbloom/features/Onboarding/ui/onboarding-4.dart';
import 'package:mindbloom/features/Onboarding/ui/onboarding-6.dart';

class OnboardingFive extends StatefulWidget {
  const OnboardingFive({super.key});

  @override
  State<OnboardingFive> createState() => _OnboardingFiveState();
}

class _OnboardingFiveState extends State<OnboardingFive> {
  String? selectedHobby;
  Widget _buildHobbyButton(String text) {
    bool isSelected = selectedHobby == text;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedHobby = text;
          });
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xff1E1E1E) : const Color(0xffF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        "How do you feel your \nenergy during the day?  ",
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  _buildHobbyButton("High - Full of energy"),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  _buildHobbyButton("Medium - My energy weakens"),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  _buildHobbyButton("Low - Need Help"),
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
                            builder: (context) => OnboardingFour(),
                          ));
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
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: const Color(0xff1E1E1E),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnboardingSix(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
