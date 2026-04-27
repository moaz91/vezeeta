import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vezeeta/features/profile/logic/profile_bloc.dart';
import 'package:vezeeta/features/profile/logic/profile_events.dart';
import 'package:vezeeta/features/profile/logic/profile_states.dart';
import 'package:vezeeta/features/auth/ui/onboarding.dart';
import 'package:vezeeta/features/my_appointment/ui/my_appointment_screen.dart';
import 'package:vezeeta/features/profile/ui/personal_information_screen.dart';
import 'package:vezeeta/features/profile/ui/medical_record_screen.dart';
import 'package:vezeeta/features/profile/ui/payment_screen.dart';
import 'package:vezeeta/features/profile/ui/setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(Dio())..add(FetchProfile()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Onboarding()),
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          final user =
          state is ProfileLoaded ? state.user : null;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                // ── Blue header ─────────────────────────────────────────
                Container(
                  color: const Color.fromRGBO(36, 124, 255, 1),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.chevron_left,
                                    color: Colors.white, size: 28),
                              ),
                              const Expanded(
                                child: Center(
                                  child: Text("Profile",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                      const SettingScreen()),
                                ),
                                child: const Icon(
                                    Icons.settings_outlined,
                                    color: Colors.white,
                                    size: 24),
                              ),
                            ],
                          ),
                        ),
                        // Reserve space so avatar overlaps the boundary
                        const SizedBox(height: 44),
                      ],
                    ),
                  ),
                ),

                // ── White card with overlapping avatar ──────────────────
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // White section
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(28)),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 64, 20, 20),
                            child: Column(
                              children: [
                                // ── Name & email only when loaded ───────
                                if (state is ProfileLoaded) ...[
                                  Text(
                                    user!.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    user.email,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(
                                            150, 150, 150, 1)),
                                  ),
                                ] else if (state is ProfileLoading) ...[
                                  // Shimmer placeholders while loading
                                  Container(
                                    width: 140,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          230, 230, 230, 1),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 190,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          240, 240, 240, 1),
                                      borderRadius:
                                      BorderRadius.circular(6),
                                    ),
                                  ),
                                ],

                                const SizedBox(height: 24),

                                // ── My Appointment / Medical records ─────
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        245, 245, 245, 1),
                                    borderRadius:
                                    BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      // Active tab — white elevated
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                const MyAppointmentScreen()),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                vertical: 14),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  14),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(
                                                      0.05),
                                                  blurRadius: 6,
                                                  offset: const Offset(
                                                      0, 1),
                                                )
                                              ],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                  "My Appointment",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight
                                                          .w600,
                                                      color: Colors
                                                          .black)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Inactive tab
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                const MedicalRecordScreen()),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                vertical: 14),
                                            child: const Center(
                                              child: Text(
                                                  "Medical records",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      color:
                                                      Color.fromRGBO(
                                                          150,
                                                          150,
                                                          150,
                                                          1))),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // ── Menu items ───────────────────────────
                                _menuItem(
                                  icon: Icons.person_outline,
                                  iconColor: const Color.fromRGBO(
                                      36, 124, 255, 1),
                                  iconBg: const Color.fromRGBO(
                                      232, 243, 255, 1),
                                  label: "Personal Information",
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PersonalInformationScreen(
                                              user: user),
                                    ),
                                  ),
                                ),
                                _menuItem(
                                  icon: Icons.science_outlined,
                                  iconColor: const Color.fromRGBO(
                                      34, 197, 94, 1),
                                  iconBg: const Color.fromRGBO(
                                      220, 252, 231, 1),
                                  label: "My Test & Diagnostic",
                                  onTap: () {},
                                ),
                                _menuItem(
                                  icon: Icons.credit_card_outlined,
                                  iconColor: const Color.fromRGBO(
                                      239, 68, 68, 1),
                                  iconBg: const Color.fromRGBO(
                                      254, 226, 226, 1),
                                  label: "Payment",
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                        const PaymentScreen()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ── Avatar overlapping blue/white boundary ─────────
                      Positioned(
                        top: -50,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromRGBO(
                                      220, 230, 245, 1),
                                  border: Border.all(
                                      color: Colors.white, width: 4),
                                ),
                                child: ClipOval(
                                  child:
                                  Image.asset("assets/rec.png",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            220, 220, 220, 1)),
                                  ),
                                  child: const Icon(Icons.edit,
                                      size: 14,
                                      color: Color.fromRGBO(
                                          36, 124, 255, 1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(label,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
                const Icon(Icons.chevron_right,
                    color: Color.fromRGBO(180, 180, 180, 1)),
              ],
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF2F2F2)),
      ],
    );
  }
}