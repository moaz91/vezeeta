import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/home/home_bloc.dart';
import '../../logic/home/home_events.dart';
import '../../logic/home/home_states.dart';

class SpecializationWidget extends StatelessWidget {
  final int count;

  const SpecializationWidget({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(Dio())..add(FetchHomeData()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final specializations = state.homeResponse.specializations
                .take(count)
                .toList();

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: specializations.map((spec) {
                return Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromRGBO(244, 248, 255, 1),
                      ),
                      child: const Icon(
                        Icons.medical_services_outlined,
                        color: Color.fromRGBO(36, 124, 255, 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      spec.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }).toList(),
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