import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/appointment_model.dart';
import 'appointment_events.dart';
import 'appointment_states.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final Dio dio;

  AppointmentBloc(this.dio) : super(AppointmentInitial()) {
    on<BookAppointment>((event, emit) async {
      emit(AppointmentLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        // Print what we're sending so we can debug if 422 happens again
        print("=== Booking appointment: doctor_id=${event.doctorId} start_time=${event.startTime} notes=${event.notes}");

        final response = await dio.post(
          'https://vcare.integration25.com/api/appointment/store',
          data: FormData.fromMap({
            'doctor_id': event.doctorId,
            'start_time': event.startTime,
            'notes': event.notes,
          }),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        print("=== Appointment response: ${response.statusCode} ${response.data}");

        if (response.statusCode == 200) {
          final appointment =
          AppointmentModel.fromJson(response.data['data'] ?? {});
          emit(AppointmentSuccess(appointment));
        } else {
          emit(const AppointmentError('Booking failed'));
        }
      } catch (e) {
        print("=== Appointment error: $e");
        emit(AppointmentError(e.toString()));
      }
    });
  }
}