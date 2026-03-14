import 'package:equatable/equatable.dart';

abstract class SpecializationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fired when DoctorSpecialityScreen opens — fetches all from /specialization/index
class FetchAllSpecializations extends SpecializationEvent {}
