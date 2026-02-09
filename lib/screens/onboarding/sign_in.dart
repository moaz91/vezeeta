import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'forgot_password.dart';
import 'signup.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 255, 255, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              "Welcome Back",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Color.fromRGBO(36, 124, 255, 1)),
            ),
            SizedBox(height: 10),
            Text(
              "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(117, 117, 117, 1)),
            ),
            SizedBox(height: 50),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(36, 124, 255, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(36, 124, 255, 1)),
                ),
                hintStyle: const TextStyle(
                    fontSize: 14, color: Color.fromRGBO(194, 194, 194, 1)),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(36, 124, 255, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(36, 124, 255, 1)),
                ),
                hintStyle: const TextStyle(
                    fontSize: 14, color: Color.fromRGBO(194, 194, 194, 1)),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  side:
                  BorderSide(color: Color.fromRGBO(194, 194, 194, 1)),
                  activeColor: Color.fromRGBO(36, 124, 255, 1),
                ),
                Text(
                  "Remember Me",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(158, 158, 158, 1)),
                ),
                Spacer(),
                GestureDetector(
                  onTap: ()=>{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()))
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Color.fromRGBO(36, 124, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignIn()));
              },
              child: Container(
                width: screenWidth * 1,
                height: 70,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(36, 124, 255, 1),
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: Divider(
                      color: Color.fromRGBO(158, 158, 158, 1),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Or sign in with",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(158, 158, 158, 1)),
                  ),
                ),
                Expanded(
                    child: Divider(
                      color: Color.fromRGBO(158, 158, 158, 1),
                    )),
              ],
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    borderRadius: BorderRadius.circular(100)),
                child: Image.asset("assets/google.png"),
              ),
              SizedBox(width: 40),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    borderRadius: BorderRadius.circular(100)),
                child: Image.asset("assets/facebook.png"),
              ),
              const SizedBox(width: 40),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    borderRadius: BorderRadius.circular(100)),
                child: Image.asset("assets/apple.png"),
              ),
            ]),
            SizedBox(height: 80),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(158, 158, 158, 1)),
                children: <TextSpan>[
                  TextSpan(
                    text: "By logging, you agree to our ",
                  ),
                  TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: " and ",
                  ),
                  TextSpan(
                      text: "PrivacyPolicy",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: ".",
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(158, 158, 158, 1)),
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Don't have an account yet? ",
                    ),
                    TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                            color: Color.fromRGBO(36, 124, 255, 1),
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()),
                            );
                          }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
