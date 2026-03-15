import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_bloc.dart';
import '../../../logic/profile/profile_events.dart';
import '../../../logic/profile/profile_states.dart';
import '../onboarding/onboarding.dart';
import 'faq_screen.dart';
import 'security_screen.dart';
import 'language_screen.dart';
import 'notification_settings_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(Dio()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Onboarding()),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.chevron_left,
                  color: Colors.black, size: 28),
            ),
            title: const Text("Setting",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black)),
            centerTitle: true,
          ),
          body: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  _settingItem(
                    icon: Icons.notifications_outlined,
                    label: "Notification",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const NotificationSettingsScreen()),
                    ),
                  ),
                  _settingItem(
                    icon: Icons.help_outline,
                    label: "FAQ",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FaqScreen()),
                    ),
                  ),
                  _settingItem(
                    icon: Icons.lock_outline,
                    label: "Security",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SecurityScreen()),
                    ),
                  ),
                  _settingItem(
                    icon: Icons.language_outlined,
                    label: "Language",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const LanguageScreen()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // ── Logout ──────────────────────────────────────────
                  GestureDetector(
                    onTap: () => _showLogoutDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: const [
                          Icon(Icons.logout,
                              color: Color.fromRGBO(239, 68, 68, 1),
                              size: 22),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text("Logout",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Color.fromRGBO(239, 68, 68, 1))),
                          ),
                          Icon(Icons.chevron_right,
                              color: Color.fromRGBO(239, 68, 68, 1)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _settingItem({
    required IconData icon,
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
                Icon(icon,
                    color: Colors.black, size: 22),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18)),
        content: const Text(
          "You'll need to enter your username\nand password next time\nyou want to login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(97, 97, 97, 1),
              height: 1.5),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(36, 124, 255, 1))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              context.read<ProfileBloc>().add(LogoutEvent());
            },
            child: const Text("Logout",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(239, 68, 68, 1))),
          ),
        ],
      ),
    );
  }
}
