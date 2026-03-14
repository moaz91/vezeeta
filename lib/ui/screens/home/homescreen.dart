// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:vezeeta/ui/screens/home/doctor_speciality_screen.dart';
import 'package:vezeeta/ui/screens/home/notifications.dart';
import 'package:vezeeta/ui/screens/home/recommendation_doctor_screen.dart';
import 'package:vezeeta/ui/screens/home/search_screen.dart';
import 'package:vezeeta/ui/screens/home/speciality_doctors_screen.dart';
import '../../widgets/recommendation_doctor_widget.dart';
import '../../../logic/home/home_bloc.dart';
import '../../../logic/home/home_events.dart';
import '../../../logic/home/home_states.dart';

// Icons map — same icons used in doctor_speciality_screen
const Map<String, String> _icons = {
  'Cardiology':       'assets/heart.png',
  'Dermatology':      'assets/stomach.png',
  'Neurology':        'assets/brain.png',
  'Orthopedics':      'assets/kidneys.png',
  'Pediatrics':       'assets/baby.png',
  'Gynecology':       'assets/man_doctor.png',
  'Ophthalmology':    'assets/eye.png',
  'Urology':          'assets/kidneys.png',
  'Gastroenterology': 'assets/intestine.png',
  'Psychiatry':       'assets/brain.png',
};

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
              _navItem(index: 0, icon: Icons.home_outlined,           activeIcon: Icons.home),
              _navItem(index: 1, icon: Icons.chat_bubble_outline,      activeIcon: Icons.chat_bubble, hasNotif: true),
              const SizedBox(width: 60),
              _navItem(index: 2, icon: Icons.calendar_today_outlined,  activeIcon: Icons.calendar_today),
              _navItem(index: 3, isAvatar: true),
            ],
          ),
          Positioned(
            top: -20,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(36, 124, 255, 1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(36, 124, 255, 0.4),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // home/index returns 5 random specializations with doctors
      // We take the first 4 and show them as the specialization icons row
      create: (_) => HomeBloc(Dio())..add(FetchHomeData()),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ── Header ───────────────────────────────────────────────
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi, Omar",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black)),
                        Text("How Are You Today?",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(97, 97, 97, 1))),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => const NotificationsScreen())),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(245, 245, 245, 1),
                            borderRadius: BorderRadius.circular(100)),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Center(
                                child: Icon(Icons.notifications_none,
                                    color: Colors.black)),
                            Positioned(
                              top: 8, right: 8,
                              child: Container(
                                width: 8, height: 8,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ── Banner ────────────────────────────────────────────────
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 197,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage("assets/background.png"),
                            fit: BoxFit.cover),
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
                                    color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 109,
                              height: 38,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(48)),
                              child: const Center(
                                child: Text("Find Nearby",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color:
                                            Color.fromRGBO(36, 124, 255, 1))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20, bottom: 0, top: -40,
                      child: Image.asset("assets/doctor_banner.png",
                          fit: BoxFit.contain),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // ── Doctor Speciality header ──────────────────────────────
                Row(
                  children: [
                    const Text("Doctor Speciality",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => const DoctorSpecialityScreen())),
                      child: const Text("See All",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(36, 124, 255, 1))),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ── 4 speciality icons from home/index ────────────────────
                // home/index returns random 5 specializations with their doctors
                // We take the first 4, map each to its icon, and make them tappable
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      // Take first 4 from whatever the API returned
                      final specs = state.homeResponse.specializations
                          .take(4)
                          .toList();

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: specs.map((spec) {
                          final iconPath =
                              _icons[spec.name] ?? 'assets/man_doctor.png';
                          return GestureDetector(
                            onTap: () {
                              // Navigate using id and name — SpecialityDoctorsScreen
                              // will call /specialization/show/{id} for fresh data
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SpecialityDoctorsScreen(
                                    specializationId: spec.id,
                                    specializationName: spec.name,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100),
                                      color: const Color.fromRGBO(
                                          244, 248, 255, 1)),
                                  child: Image.asset(iconPath,
                                      width: 24, height: 24),
                                ),
                                const SizedBox(height: 10),
                                Text(spec.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black)),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }

                    // Placeholder while loading — keeps layout stable
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (_) => Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromRGBO(244, 248, 255, 1)),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 50),

                // ── Recommendation Doctor header ───────────────────────────
                Row(
                  children: [
                    const Text("Recommendation Doctor",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const RecommendationDoctorScreen())),
                      child: const Text("See All",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(36, 124, 255, 1))),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                RecommendationDoctorWidget(count: 3),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
