import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import 'profile_events.dart';
import 'profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Dio dio;

  ProfileBloc(this.dio) : super(ProfileInitial()) {

    // ── Fetch profile ───────────────────────────────────────────────────────
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        final response = await dio.get(
          'https://vcare.integration25.com/api/user/profile',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode == 200) {
          final user = UserModel.fromJson(response.data);
          emit(ProfileLoaded(user));
        } else {
          emit(const ProfileError('Failed to load profile'));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    // ── Update profile ──────────────────────────────────────────────────────
    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        final response = await dio.post(
          'https://vcare.integration25.com/api/user/update',
          data: FormData.fromMap({
            'name': event.name,
            'email': event.email,
            'phone': event.phone,
            'gender': event.gender,
          }),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode == 200) {
          final user = UserModel.fromJson(response.data);
          emit(ProfileUpdated(user));
        } else {
          emit(const ProfileError('Failed to update profile'));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    // ── Logout ──────────────────────────────────────────────────────────────
    on<LogoutEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        await dio.post(
          'https://vcare.integration25.com/api/auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        // Clear saved token and remember me flag regardless of response
        await prefs.remove('token');
        await prefs.remove('saved_email');
        await prefs.setBool('remember_me', false);

        emit(ProfileLoggedOut());
      } catch (e) {
        // Even if API call fails, clear local token and log out
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        await prefs.remove('saved_email');
        await prefs.setBool('remember_me', false);
        emit(ProfileLoggedOut());
      }
    });
  }
}
