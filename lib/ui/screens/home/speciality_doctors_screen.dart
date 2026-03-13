import 'package:flutter/material.dart';
import '../../../models/home_model.dart';
import '../../widgets/speciality_doctors_widget.dart';

// Screen that shows all doctors for a specific specialization.
// Receives a HomeSpecialization object from the caller (doctor_speciality_screen).
class SpecialityDoctorsScreen extends StatelessWidget {
  final HomeSpecialization specialization;

  const SpecialityDoctorsScreen({
    super.key,
    required this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),

      // ── AppBar ────────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color.fromRGBO(237, 237, 237, 1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chevron_left, color: Colors.black),
          ),
        ),
        // The title is the specialization name passed from the previous screen
        title: Text(
          specialization.name,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black),
        ),
        centerTitle: true,
      ),

      // ── Body ──────────────────────────────────────────────────────────────
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Show how many doctors were found
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${specialization.doctors.length} doctors found",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),

            const SizedBox(height: 16),

            // ── The reusable widget ─────────────────────────────────────────
            // Pass the specialization.id — the widget handles all BLoC logic
            Expanded(
              child: SingleChildScrollView(
                child: SpecialityDoctorsWidget(
                  specializationId: specialization.id,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}