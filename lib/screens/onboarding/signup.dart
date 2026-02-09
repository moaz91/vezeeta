import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),

            const Text(
              "Create Account",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Color.fromRGBO(36, 124, 255, 1),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            ),

            const SizedBox(height: 50),

            /// Email
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(194, 194, 194, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(36, 124, 255, 1),
                  ),
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(194, 194, 194, 1),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Password
            TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(194, 194, 194, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(36, 124, 255, 1),
                  ),
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(194, 194, 194, 1),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Phone number with country picker
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(253, 253, 255, 1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromRGBO(194, 194, 194, 1),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 135,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        iconTheme: const IconThemeData(size: 16),
                      ),
                      child: CountryCodePicker(
                        margin: EdgeInsets.zero,
                        flagWidth: 30,
                        padding: EdgeInsets.only(left: 0, right: 0),
                        initialSelection: 'EG',
                        favorite: const ['+20', 'EG', '+966', 'SA'],
                        showFlag: true,
                        showDropDownButton: true,
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      color: Color.fromRGBO(194, 194, 194, 1),
                    ),
                  ),
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Your number",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(194, 194, 194, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Sign up button
            Container(
              width: screenWidth,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(36, 124, 255, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Row(
              children: [
                Expanded(
                  child: Divider(color: Color.fromRGBO(158, 158, 158, 1)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Or sign up with",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(158, 158, 158, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(color: Color.fromRGBO(158, 158, 158, 1)),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialIcon("assets/google.png"),
                const SizedBox(width: 40),
                socialIcon("assets/facebook.png"),
                const SizedBox(width: 40),
                socialIcon("assets/apple.png"),
              ],
            ),

            const SizedBox(height: 50),

            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(158, 158, 158, 1),
                  ),
                  children: [
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: "Sign In",
                      style: const TextStyle(
                        color: Color.fromRGBO(36, 124, 255, 1),
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget socialIcon(String asset) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image.asset(asset),
    );
  }
}
