import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../logic/auth/auth_events.dart';
import '../home/homescreen.dart';
import '../../../logic/auth/auth_bloc.dart';
import '../../../logic/auth/auth_states.dart';
import 'forgot_password.dart';
import 'signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false; // NEW: tracks checkbox state

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('remember_me') ?? false;
    if (rememberMe) {
      final savedEmail = prefs.getString('saved_email') ?? '';
      setState(() {
        _emailController.text = savedEmail;
        _rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthBloc(Dio()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
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
                    controller: _emailController,
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
                          fontSize: 14,
                          color: Color.fromRGBO(194, 194, 194, 1)),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
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
                          fontSize: 14,
                          color: Color.fromRGBO(194, 194, 194, 1)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() => _rememberMe = value!);
                        },
                        side: BorderSide(
                            color: Color.fromRGBO(194, 194, 194, 1)),
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
                        onTap: () => {
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
                      context.read<AuthBloc>().add(
                        LoginEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                          rememberMe: _rememberMe,
                        ),
                      );
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        TextSpan(text: "By logging, you agree to our "),
                        TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(text: " and "),
                        TextSpan(
                            text: "PrivacyPolicy",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(text: "."),
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
        },
      ),
    );
  }
}