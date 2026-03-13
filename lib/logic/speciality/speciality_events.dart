import 'package:equatable/equatable.dart';

// All events that can happen in the Speciality feature
abstract class SpecialityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fired when the screen opens — passes the specialization ID to filter by
class FetchSpecialityDoctors extends SpecialityEvent {
  final int specializationId;

  FetchSpecialityDoctors(this.specializationId);

  @override
  List<Object?> get props => [specializationId];
}