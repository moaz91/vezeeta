import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Omar",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    Text(
                      "How Are You Today?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color.fromRGBO(97, 97, 97, 1)),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.notifications_none),
                )
              ],
            ),
            SizedBox(height: 30),
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner container
                Container(
                  width: double.infinity,
                  height: 197,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "Book and schedule with nearest doctor",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 109,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(48),
                          ),
                          child: Center(
                            child: Text(
                              "Find Nearby",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromRGBO(36, 124, 255, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  top: -40,
                  child: Image.asset(
                    "assets/doctor_banner.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text("Doctor Speciality",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                Spacer(),
                Text("See All",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color.fromRGBO(36, 124, 255, 1)),)
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)
                      ),
                      child: Image.asset("assets/man_doctor.png",width: 24,height: 24,),
                    ),
                    SizedBox(height: 10),
                    Text("General",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),)
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)
                      ),
                      child: Image.asset("assets/brain.png",width: 24,height: 24,),
                    ),
                    SizedBox(height: 10),
                    Text("Neurologic",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),)
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)
                      ),
                      child: Image.asset("assets/baby.png",width: 24,height: 24,),
                    ),
                    SizedBox(height: 10),
                    Text("Pediatric",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),)
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)
                      ),
                      child: Image.asset("assets/kidneys.png",width: 24,height: 24,),
                    ),
                    SizedBox(height: 10),
                    Text("Radiology",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),)
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text("Recommendation Doctor",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                Spacer(),
                Text("See All",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color.fromRGBO(36, 124, 255, 1)),)
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 126,
              width: double.infinity,
              child:Row(
                children: [Container(
                    width:110,
                    height: 110,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset("rec.png"))],
              ),
            )
          ],
        ),
      ),
    );
  }
}