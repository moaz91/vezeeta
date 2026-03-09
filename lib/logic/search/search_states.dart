import 'package:equatable/equatable.dart';
import '../../models/doctor_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Doctor> doctors;

  SearchLoaded(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}