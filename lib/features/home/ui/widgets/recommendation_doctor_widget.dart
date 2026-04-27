import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vezeeta/features/home/logic/home_bloc.dart';
import 'package:vezeeta/features/home/logic/home_events.dart';
import 'package:vezeeta/features/home/logic/home_states.dart';
import 'package:vezeeta/features/home/ui/screens/doctor_details.dart';

class RecommendationDoctorWidget extends StatelessWidget {
  final int count;

  const RecommendationDoctorWidget({super.key, required this.count});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(Dio())..add(FetchHomeData()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            // flatten all doctors from all specializations into one list
            final allDoctors = state.homeResponse.specializations
                .expand((spec) => spec.doctors)
                .take(count)
                .toList();

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allDoctors.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final doctor = allDoctors[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorDetails(doctor: doctor),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 126,
                    width: double.infinity,
                    child: Row(
                      children: [
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
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 40),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
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
                                  const Text("|",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(117, 117, 117, 1))),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      doctor.city.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Color.fromRGBO(255, 203, 0, 1),
                                      size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    doctor.appointPrice.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(66, 66, 66, 1),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "(${doctor.degree})",
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
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}