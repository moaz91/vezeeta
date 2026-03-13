import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/home_model.dart';
import '../../models/doctor_model.dart';
import 'speciality_events.dart';
import 'speciality_states.dart';

class SpecialityBloc extends Bloc<SpecialityEvent, SpecialityState> {
  final Dio dio;

  SpecialityBloc(this.dio) : super(SpecialityInitial()) {

    on<FetchSpecialityDoctors>((event, emit) async {
      emit(SpecialityLoading());

      try {
        // Read the saved token from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        // Reuse the same home endpoint — it returns all specializations with their doctors
        final response = await dio.get(
          'https://vcare.integration25.com/api/home/index',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Parse the full home response
          final homeResponse = HomeResponse.fromJson(response.data);

          // Find the specialization that matches the ID we want
          // firstWhere throws if not found, orElse returns null-safe fallback
          final matched = homeResponse.specializations
              .where((spec) => spec.id == event.specializationId)
              .toList();

          // Extract just the doctors list from the matched specialization
          final List<Doctor> doctors =
          matched.isNotEmpty ? matched.first.doctors : [];

          emit(SpecialityLoaded(doctors));
        } else {
          emit(const SpecialityError('Failed to load doctors'));
        }
      } catch (e) {
        emit(SpecialityError(e.toString()));
      }
    });
  }
}