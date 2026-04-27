import 'package:equatable/equatable.dart';
import 'package:vezeeta/features/appointment/data/appointment_model.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();
  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;
  const AppointmentsLoaded(this.appointments);
  @override
  List<Object?> get props => [appointments];
}

class AppointmentBooked extends AppointmentState {
  final AppointmentModel appointment;
  const AppointmentBooked(this.appointment);
  @override
  List<Object?> get props => [appointment];
}

class AppointmentError extends AppointmentState {
  final String message;
  const AppointmentError(this.message);
  @override
  List<Object?> get props => [message];
}
