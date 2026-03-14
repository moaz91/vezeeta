import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/specialization/specialization_bloc.dart';
import '../../../logic/specialization/specialization_events.dart';
import '../../../logic/specialization/specialization_states.dart';
import 'speciality_doctors_screen.dart';

// Icons map — keyed by exact API specialization name
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

class DoctorSpecialityScreen extends StatelessWidget {
  const DoctorSpecialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Uses SpecializationBloc which calls /specialization/index
      // This endpoint returns ALL specializations every time — no randomness
      create: (_) =>
          SpecializationBloc(Dio())..add(FetchAllSpecializations()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Doctor Speciality",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        body: BlocBuilder<SpecializationBloc, SpecializationState>(
          builder: (context, state) {
            if (state is SpecializationInitial ||
                state is SpecializationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SpecializationError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(state.message,
                      style: const TextStyle(color: Colors.red)),
                ),
              );
            }

            if (state is SpecializationLoaded) {
              final specs = state.specializations;

              return GridView.builder(
                padding: const EdgeInsets.all(30),
                itemCount: specs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final spec = specs[index];
                  final iconPath =
                      _icons[spec.name] ?? 'assets/man_doctor.png';

                  return GestureDetector(
                    onTap: () {
                      // Navigate passing the id and name
                      // SpecialityDoctorsScreen will call /specialization/show/{id}
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color.fromRGBO(244, 248, 255, 1),
                          ),
                          child:
                              Image.asset(iconPath, width: 40, height: 40),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          spec.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
