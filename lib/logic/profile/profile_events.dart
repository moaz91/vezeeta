import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fired when profile screen opens
class FetchProfile extends ProfileEvent {}

// Fired when user taps Save on personal information screen
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

// Fired when user confirms logout
class LogoutEvent extends ProfileEvent {}
