import 'package:equatable/equatable.dart';
import '../../models/doctor_model.dart';

// All possible UI states for the Speciality doctors screen
abstract class SpecialityState extends Equatable {
  const SpecialityState();

  @override
  List<Object?> get props => [];
}

// Before anything is fetched
class SpecialityInitial extends SpecialityState {}

// While the API call is in progress — show a spinner
class SpecialityLoading extends SpecialityState {}

// API returned successfully — holds the filtered list of doctors
class SpecialityLoaded extends SpecialityState {
  final List<Doctor> doctors;

  const SpecialityLoaded(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

// Something went wrong — holds the error message
class SpecialityError extends SpecialityState {
  final String message;

  const SpecialityError(this.message);

  @override
  List<Object?> get props => [message];
}