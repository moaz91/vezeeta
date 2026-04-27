import 'package:equatable/equatable.dart';
import 'package:vezeeta/features/auth/data/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final AuthModel authModel;

  const AuthLoaded(this.authModel);

  @override
  List<Object?> get props => [authModel];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}