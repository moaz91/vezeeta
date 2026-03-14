import 'package:equatable/equatable.dart';
import '../../models/appointment_model.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();
  @override
  List<Object?> get props => [];
}

// Before the user submits anything
class AppointmentInitial extends AppointmentState {}

// While the API call is in progress — show loading on Book Now button
class AppointmentLoading extends AppointmentState {}

// Booking succeeded — navigate to confirmation screen
class AppointmentSuccess extends AppointmentState {
  final AppointmentModel appointment;
  const AppointmentSuccess(this.appointment);
  @override
  List<Object?> get props => [appointment];
}

// Something went wrong
class AppointmentError extends AppointmentState {
  final String message;
  const AppointmentError(this.message);
  @override
  List<Object?> get props => [message];
}
