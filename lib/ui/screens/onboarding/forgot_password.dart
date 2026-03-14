
import 'package:flutter/material.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 255, 255, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              "Reset Password",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Color.fromRGBO(36, 124, 255, 1)),
            ),
            SizedBox(height: 10),
            Text(
              "At our app, we take the security of your information seriously.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(117, 117, 117, 1)),
            ),
            SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                hintText: "Email or Phone Number",
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
Spacer(),
Container(
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
          ],
        ),
      ),
    );
  }
}
