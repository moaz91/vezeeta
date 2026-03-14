import 'package:vezeeta/ui/screens/onboarding/sign_in.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment(0, 0.6),
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                    stops: [0.0, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Image.asset(
                    'assets/splash_background.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logo.png', width: screenWidth * 0.12),
                        const SizedBox(width: 10),
                        Text(
                          "Docdoc",
                          style: TextStyle(
                            fontSize: screenWidth * 1 / 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                              stops: [0.5, 0.9],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.asset(
                            'assets/doctor.png',
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 20,
                          right: 20,
                          child: Text(
                            "Best Doctor\nAppointment App",
                            style: TextStyle(
                              fontSize: screenWidth * 0.09,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(36, 124, 255, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth *0.05),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.",style: TextStyle(
                          color: Color.fromRGBO(117, 117, 117, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.03
                        ),textAlign: TextAlign.center,),
                      ),
                    )
                ]),
              ),
            ],
          ),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));},
            child: Container(
              width: screenWidth * 0.8,
              height: 70,
              decoration: BoxDecoration(
                color: Color.fromRGBO(36, 124, 255, 1),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Center(
                child: Text("Get Started", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
