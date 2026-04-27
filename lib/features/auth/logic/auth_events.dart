import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  LoginEvent({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String password;
  final String passwordConfirmation;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props => [name, email, phone, gender, password, passwordConfirmation];
}