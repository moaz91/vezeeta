// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vezeeta/ui/screens/home/doctor_speciality_screen.dart';
import 'package:vezeeta/ui/screens/home/notifications.dart';
import 'package:vezeeta/ui/screens/home/recommendation_doctor_screen.dart';
import 'package:vezeeta/ui/screens/home/search_screen.dart';

class SpecialityModel {
  final String label;
  final String image;
  SpecialityModel({required this.label, required this.image});
}

final List<SpecialityModel> specialities = [
  SpecialityModel(label: "General",    image: "assets/man_doctor.png"),
  SpecialityModel(label: "Neurologic", image: "assets/brain.png"),
  SpecialityModel(label: "Pediatric",  image: "assets/baby.png"),
  SpecialityModel(label: "Radiology",  image: "assets/kidneys.png"),
];

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeBody(),
    const _PlaceholderPage(label: "Messages"),
    const _PlaceholderPage(label: "Schedule"),
    const _PlaceholderPage(label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(index: 0, icon: Icons.home_outlined, activeIcon: Icons.home),
              _navItem(index: 1, icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, hasNotif: true),
              const SizedBox(width: 60),
              _navItem(index: 2, icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today),
              _navItem(index: 3, isAvatar: true),
            ],
          ),
          Positioned(
            top: -20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                );
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(36, 124, 255, 1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(36, 124, 255, 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.search, color: Colors.white, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    int? index,
    IconData? icon,
    IconData? activeIcon,
    bool hasNotif = false,
    bool isAvatar = false,
  }) {
    final isActive = index == _currentIndex;

    return GestureDetector(
      onTap: index != null ? () => setState(() => _currentIndex = index) : null,
      child: Container(
        width: 50,
        height: 80,
        color: Colors.transparent,
        child: Center(
          child: isAvatar
              ? Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage("assets/rec.png"),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: isActive
                    ? const Color.fromRGBO(36, 124, 255, 1)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          )
              : Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                size: 26,
                color: isActive
                    ? const Color.fromRGBO(36, 124, 255, 1)
                    : const Color.fromRGBO(180, 180, 180, 1),
              ),
              if (hasNotif)
                Positioned(
                  top: -2,
                  right: -4,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String label;
  const _PlaceholderPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  String _formatReviews(int reviews) {
    if (reviews >= 1000) return "${(reviews / 1000).toStringAsFixed(1)}k";
    return reviews.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
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
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 245, 245, 1),
                          borderRadius: BorderRadius.circular(100)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Center(
                            child: Icon(Icons.notifications_none, color: Colors.black),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 197,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
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
                          const SizedBox(
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
                          const Spacer(),
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

              const SizedBox(height: 50),

              Row(
                children: [
                  const Text(
                    "Doctor Speciality",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DoctorSpecialityScreen()),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(36, 124, 255, 1)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: specialities.map((spec) {
                  return Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color.fromRGBO(244, 248, 255, 1)),
                        child: Image.asset(spec.image, width: 24, height: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        spec.label,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ],
                  );
                }).toList(),
              ),

              const SizedBox(height: 50),

              Row(
                children: [
                  const Text(
                    "Recommendation Doctor",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RecommendationDoctorScreen()),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(36, 124, 255, 1)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allDoctors.length > 3 ? 3 : allDoctors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final doc = allDoctors[index];
                  return SizedBox(
                    height: 126,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(doc.image),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(doc.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(doc.speciality,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color.fromRGBO(117, 117, 117, 1))),
                                  const SizedBox(width: 5),
                                  Text("|",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color.fromRGBO(117, 117, 117, 1))),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(doc.hospital,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Color.fromRGBO(117, 117, 117, 1))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Color.fromRGBO(255, 203, 0, 1), size: 18),
                                  const SizedBox(width: 5),
                                  Text(doc.rating.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(66, 66, 66, 1))),
                                  const SizedBox(width: 5),
                                  Text("(${_formatReviews(doc.reviews)} reviews)",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(66, 66, 66, 1))),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}