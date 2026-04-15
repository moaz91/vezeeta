import 'package:equatable/equatable.dart';
import '../../models/specialization_model.dart';

abstract class SpecializationState extends Equatable {
  const SpecializationState();
  @override
  List<Object?> get props => [];
}

class SpecializationInitial extends SpecializationState {}

class SpecializationLoading extends SpecializationState {}

class SpecializationLoaded extends SpecializationState {
  final List<SpecializationItem> specializations;
  const SpecializationLoaded(this.specializations);
  @override
  List<Object?> get props => [specializations];
}

class SpecializationError extends SpecializationState {
  final String message;
  const SpecializationError(this.message);
  @override
  List<Object?> get props => [message];
}
