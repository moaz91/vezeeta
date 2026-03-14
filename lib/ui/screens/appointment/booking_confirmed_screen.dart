import 'package:flutter/material.dart';
import '../../../models/doctor_model.dart';
import '../home/homescreen.dart';

class BookingConfirmedScreen extends StatelessWidget {
  final Doctor doctor;
  final String selectedDate;
  final String selectedTime;
  final String appointmentType;

  const BookingConfirmedScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.appointmentType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
        ),
        title: const Text("Details",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // ── Success checkmark ─────────────────────────────────────────
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(34, 197, 94, 1),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 44),
            ),
            const SizedBox(height: 20),
            const Text("Booking Confirmed",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),

            const SizedBox(height: 40),

            // ── Booking Information ───────────────────────────────────────
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Booking Information",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
            const SizedBox(height: 16),

            _infoRow(
              icon: Icons.calendar_today_outlined,
              title: "Date & Time",
              value: "$selectedDate\n$selectedTime",
            ),
            const Divider(color: Color(0xFFF2F2F2)),
            _infoRow(
              icon: Icons.medical_services_outlined,
              title: "Appointment Type",
              value: appointmentType,
              trailing: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(36, 124, 255, 1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Get Location",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(36, 124, 255, 1))),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Doctor Information ────────────────────────────────────────
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Doctor Information",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(250, 250, 250, 1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      doctor.photo,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 56,
                        height: 56,
                        color: const Color.fromRGBO(244, 248, 255, 1),
                        child: const Icon(Icons.person, size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.name,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                        const SizedBox(height: 4),
                        Text(
                          "${doctor.specialization.name}  |  ${doctor.city.name}",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(117, 117, 117, 1)),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Color.fromRGBO(255, 203, 0, 1),
                                size: 14),
                            const SizedBox(width: 4),
                            Text(doctor.degree,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color:
                                        Color.fromRGBO(66, 66, 66, 1))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              // Go back to home, clearing the whole booking stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Homescreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(36, 124, 255, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text("Done",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(232, 243, 255, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                color: const Color.fromRGBO(36, 124, 255, 1), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(117, 117, 117, 1))),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
