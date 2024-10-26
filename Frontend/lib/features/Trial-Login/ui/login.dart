import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
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
                      controller: email,
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
                        backgroundColor: const Color(0xffF49728),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Log In',
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account?',
                    style: GoogleFonts.poppins(
                        fontSize: height * 0.017, fontWeight: FontWeight.w300),
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            ' Sign up',
                            style: GoogleFonts.poppins(
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffF49728),
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
        ),
      ),
    );
  }
}
