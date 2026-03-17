import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/appointment_model.dart';
import 'appointment_events.dart';
import 'appointment_states.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final Dio dio;

  AppointmentBloc(this.dio) : super(AppointmentInitial()) {

    on<FetchAppointments>((event, emit) async {
      emit(AppointmentLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        final response = await dio.get(
          'https://vcare.integration25.com/api/appointment/index',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode == 200) {
          final List<AppointmentModel> appointments =
              List<AppointmentModel>.from(
            (response.data['data'] ?? [])
                .map((a) => AppointmentModel.fromJson(a)),
          );
          emit(AppointmentsLoaded(appointments));
        } else {
          emit(const AppointmentError('Failed to load appointments'));
        }
      } catch (e) {
        emit(AppointmentError(e.toString()));
      }
    });

    on<BookAppointment>((event, emit) async {
      emit(AppointmentLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        print("=== Booking: doctor_id=${event.doctorId} start_time=${event.startTime}");

        final response = await dio.post(
          'https://vcare.integration25.com/api/appointment/store',
          data: FormData.fromMap({
            'doctor_id': event.doctorId,
            'start_time': event.startTime,
            'notes': event.notes,
          }),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        print("=== Appointment response: ${response.statusCode}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          final appointment =
              AppointmentModel.fromJson(response.data['data'] ?? {});
          emit(AppointmentBooked(appointment));
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
