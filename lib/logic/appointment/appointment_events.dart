import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookAppointment extends AppointmentEvent {
  final int doctorId;
  final String startTime; // format: "2023-10-10 14:00"
  final String notes;

  BookAppointment({
    required this.doctorId,
    required this.startTime,
    required this.notes,
  });

  @override
  List<Object?> get props => [doctorId, startTime, notes];
}