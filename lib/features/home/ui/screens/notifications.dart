import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color.fromRGBO(36, 124, 255, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "2 NEW",
                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(150, 150, 150, 1))),
                  Text("Mark all as read",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(36, 124, 255, 1))),
                ],
              ),
            ),
            _notifItem(
              icon: Icons.calendar_month_outlined,
              iconBg: Color.fromRGBO(232, 248, 240, 1),
              iconColor: Color.fromRGBO(34, 197, 94, 1),
              title: "Appointment Success",
              subtitle: "Congratulations - your appointment is confirmed! We're looking forward to meeting with you and helping you achieve your goals.",
              time: "1h",
              isUnread: false,
            ),
            _notifItem(
              icon: Icons.calendar_today_outlined,
              iconBg: Color.fromRGBO(232, 243, 255, 1),
              iconColor: Color.fromRGBO(36, 124, 255, 1),
              title: "Schedule Changed",
              subtitle: "You have successfully changed your appointment with Dr. Randy Wigham. Don't forget to active your reminder.",
              time: "5h",
              isUnread: true,
            ),
            _notifItem(
              icon: Icons.videocam_outlined,
              iconBg: Color.fromRGBO(232, 248, 240, 1),
              iconColor: Color.fromRGBO(34, 197, 94, 1),
              title: "Video Call Appointment",
              subtitle: "We'll send you a link to join the call at the booking details, so all you need is a computer or mobile device with a camera and an internet connection.",
              time: "7h",
              isUnread: false,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text("Yesterday",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(150, 150, 150, 1))),
            ),
            _notifItem(
              icon: Icons.calendar_month_outlined,
              iconBg: Color.fromRGBO(255, 235, 235, 1),
              iconColor: Color.fromRGBO(239, 68, 68, 1),
              title: "Appointment Cancelled",
              subtitle: "You have successfully canceled your appointment with Dr. Randy Wigham. 50% of the funds will be returned to your account.",
              time: "1d",
              isUnread: false,
            ),
            _notifItem(
              icon: Icons.wallet_outlined,
              iconBg: Color.fromRGBO(232, 243, 255, 1),
              iconColor: Color.fromRGBO(36, 124, 255, 1),
              title: "New Payment Added!",
              subtitle: "Your payment has been successfully linked with Docdoc.",
              time: "1d",
              isUnread: true,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _notifItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      color: isUnread ? Color.fromRGBO(245, 249, 255, 1) : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                    ),
                    Text(time,
                        style: TextStyle(
                            fontSize: 12, color: Color.fromRGBO(150, 150, 150, 1))),
                    if (isUnread) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(97, 97, 97, 1),
                        height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}