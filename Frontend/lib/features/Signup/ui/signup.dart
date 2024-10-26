import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    void _handleGoogleLogin() async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;

          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          UserCredential credentials =
              await FirebaseAuth.instance.signInWithCredential(credential);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('uid', credentials.user!.uid);

          Navigator.pushNamed(context, 'onboarding');
        }
      } catch (e) {
        log(e.toString());
      }
    }

    void _singupButtonClicked() async {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        UserCredential credential =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        if (credential.user != null) {
          await prefs.setString('uid', credential.user!.uid.toString());
          Navigator.pushNamed(context, 'onboarding');
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Signup',
                  style: GoogleFonts.inter(
                      fontSize: 70, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter your email-id",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter your password",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.81,
                  height: height * 0.064,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff87A2FF),
                    ),
                    onPressed: _singupButtonClicked,
                    child: Text(
                      'Signup',
                      style: GoogleFonts.poppins(
                          fontSize: height * 0.025, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: _handleGoogleLogin,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/google.jpg"),
                          height: 42,
                          width: 42,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 8),
                          child: Text(
                            'Sign up with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text.rich(
                    TextSpan(
                      text: 'Have an account?',
                      style: GoogleFonts.poppins(
                          fontSize: height * 0.017,
                          fontWeight: FontWeight.w300),
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              Navigator.popAndPushNamed(context, 'login');
                            },
                            child: Text(
                              ' Login',
                              style: GoogleFonts.poppins(
                                  fontSize: height * 0.017,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff87A2FF),
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      const Color.fromRGBO(14, 15, 60, 1)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ])
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
