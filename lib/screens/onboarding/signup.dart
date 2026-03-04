import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/auth/auth_events.dart';
import '../../logic/auth/auth_states.dart';
import '../home/homescreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedGender = '0';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _phoneController.dispose();
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
              MaterialPageRoute(builder: (context) => const SignIn()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            backgroundColor: const Color.fromRGBO(254, 255, 255, 1),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

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

                  const SizedBox(height: 30),

                  TextField(
                    controller: _nameController,
                    decoration: _inputDecoration("Full Name"),
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration("Email"),
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration("Password"),
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: _passwordConfirmController,
                    obscureText: true,
                    decoration: _inputDecoration("Confirm Password"),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(253, 253, 255, 1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color.fromRGBO(194, 194, 194, 1)),
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
                              padding: EdgeInsets.zero,
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
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
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

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(253, 253, 255, 1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color.fromRGBO(194, 194, 194, 1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedGender,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: '0', child: Text("Male")),
                          DropdownMenuItem(value: '1', child: Text("Female")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(
                        RegisterEvent(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          passwordConfirmation: _passwordConfirmController.text,
                          phone: _phoneController.text,
                          gender: _selectedGender,
                        ),
                      );
                    },
                    child: Container(
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
                  ),

                  const SizedBox(height: 20),

                  const Row(
                    children: [
                      Expanded(child: Divider(color: Color.fromRGBO(158, 158, 158, 1))),
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
                      Expanded(child: Divider(color: Color.fromRGBO(158, 158, 158, 1))),
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

                  const SizedBox(height: 30),

                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(158, 158, 158, 1),
                      ),
                      children: [
                        TextSpan(text: "By logging, you agree to our "),
                        TextSpan(
                          text: "Terms & Conditions",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(text: "."),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color.fromRGBO(253, 253, 255, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color.fromRGBO(194, 194, 194, 1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color.fromRGBO(36, 124, 255, 1)),
      ),
      hintStyle: const TextStyle(
        fontSize: 14,
        color: Color.fromRGBO(194, 194, 194, 1),
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