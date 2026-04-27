import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vezeeta/core/cache/cache_helper.dart';
import 'package:vezeeta/features/auth/data/auth_model.dart';
import 'package:vezeeta/features/auth/logic/auth_events.dart';
import 'package:vezeeta/features/auth/logic/auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final Dio dio;

  AuthBloc(this.dio) : super(AuthInitial()) {

    on<LoginEvent>((event, emit) async {

      emit(AuthLoading());

      try {
        final response = await dio.post(
          'https://vcare.integration25.com/api/auth/login',
          data: FormData.fromMap({
            'email': event.email,
            'password': event.password,
          }),
        );

        if (response.statusCode == 200) {

          final authModel = AuthModel.fromJson(response.data);

          await CacheHelper.saveToken(authModel.token);

          if (event.rememberMe) {
            await CacheHelper.setString('saved_email', event.email);
            await CacheHelper.setBool('remember_me', true);
          } else {
            await CacheHelper.remove('saved_email');
            await CacheHelper.setBool('remember_me', false);
          }

          emit(AuthLoaded(authModel));

        } else {
          emit(AuthError('Login failed'));
        }

      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await dio.post(
          'https://vcare.integration25.com/api/auth/register',
          data: FormData.fromMap({
            'name': event.name,
            'email': event.email,
            'phone': event.phone,
            'gender': event.gender,
            'password': event.password,
            'password_confirmation': event.passwordConfirmation,
          }),
        );
        if (response.statusCode == 200) {
          final authModel = AuthModel.fromJson(response.data);
          emit(AuthLoaded(authModel));
        } else {
          emit(AuthError('Register failed'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
