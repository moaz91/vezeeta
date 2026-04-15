import 'package:equatable/equatable.dart';

abstract class SpecializationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllSpecializations extends SpecializationEvent {}
