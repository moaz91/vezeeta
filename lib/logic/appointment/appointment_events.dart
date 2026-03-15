import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fired when MyAppointmentScreen opens
class FetchAppointments extends AppointmentEvent {}

// Fired when user taps "Book Now" on summary screen
class BookAppointment extends AppointmentEvent {
  final int doctorId;
  final String startTime;
  final String notes;

  BookAppointment({
    required this.doctorId,
    required this.startTime,
    required this.notes,
  });

  @override
  List<Object?> get props => [doctorId, startTime, notes];
}
