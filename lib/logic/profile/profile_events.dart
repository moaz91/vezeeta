import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String gender;

  UpdateProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  @override
  List<Object?> get props => [name, email, phone, gender];
}

class LogoutEvent extends ProfileEvent {}
