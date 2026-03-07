import 'package:flutter/material.dart';

class DoctorSpecialityScreen extends StatelessWidget {
  const DoctorSpecialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text("Doctor Speciality",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
    ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/man_doctor.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "General",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/ent.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "ENT",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/baby.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pediatric",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/kidneys.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Urologist",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/teeth.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Dentistry",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/intestine.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Intestine",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/stomach.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "histologist",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/hepatology.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Hepatology",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/heart.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "cardiologist",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/brain.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Neurologic",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/lungs.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "pulmonary",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(244, 248, 255, 1)),
                      child: Image.asset(
                        "assets/eye.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Optometry",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
