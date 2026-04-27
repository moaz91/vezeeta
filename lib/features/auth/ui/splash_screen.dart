// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vezeeta/core/cache/cache_helper.dart';
import 'package:vezeeta/features/home/ui/screens/homescreen.dart';
import 'package:vezeeta/features/auth/ui/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = CacheHelper.getToken() ?? '';
    final rememberMe = CacheHelper.getBool('remember_me') ?? false;

    if (token.isNotEmpty && rememberMe) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Homescreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_background.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: screenWidth * 0.25,
              ),
              const SizedBox(width: 16),
              Text(
                "DocDoc",
                style: TextStyle(
                  fontSize: screenWidth * 0.125,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}