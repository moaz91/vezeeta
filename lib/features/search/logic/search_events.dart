import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchDoctors extends SearchEvent {
  final String name;

  SearchDoctors(this.name);

  @override
  List<Object?> get props => [name];
}