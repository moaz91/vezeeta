import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/speciality/speciality_bloc.dart';
import '../../logic/speciality/speciality_events.dart';
import '../../logic/speciality/speciality_states.dart';
import '../screens/home/doctor_details.dart';

// A reusable widget — just pass it a specializationId and it fetches + displays
// the doctors for that specialization. Same card UI as RecommendationDoctorWidget.
class SpecialityDoctorsWidget extends StatelessWidget {
  final int specializationId;

  const SpecialityDoctorsWidget({
    super.key,
    required this.specializationId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create the bloc and immediately fire the fetch event
      create: (context) =>
      SpecialityBloc(Dio())..add(FetchSpecialityDoctors(specializationId)),

      child: BlocBuilder<SpecialityBloc, SpecialityState>(
        builder: (context, state) {

          // ── Loading state: show a centered spinner ──────────────────────
          if (state is SpecialityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ── Loaded state: render the doctor cards ───────────────────────
          else if (state is SpecialityLoaded) {
            if (state.doctors.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_search,
                        size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      "No doctors found",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            }

            // ListView of doctor cards — shrinkWrap so it works inside a Column
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.doctors.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final doctor = state.doctors[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to doctor details passing the full Doctor object
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorDetails(doctor: doctor),
                      ),
                    );
                  },
                  child: Container(
                    height: 126,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),

                        // ── Doctor photo ──────────────────────────────────
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(244, 248, 255, 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              doctor.photo,
                              fit: BoxFit.cover,
                              // Fallback icon if image fails to load
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.person, size: 40),
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        // ── Doctor info ───────────────────────────────────
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),

                              // Name
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Specialization | City
                              Row(
                                children: [
                                  Text(
                                    doctor.specialization.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "|",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                        Color.fromRGBO(117, 117, 117, 1)),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      doctor.city.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color:
                                        Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Degree (shown where rating usually goes)
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Color.fromRGBO(255, 203, 0, 1),
                                      size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    doctor.degree,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(66, 66, 66, 1),
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // ── Error state ─────────────────────────────────────────────────
          else if (state is SpecialityError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // ── Initial state (before anything loads) ───────────────────────
          return const SizedBox();
        },
      ),
    );
  }
}