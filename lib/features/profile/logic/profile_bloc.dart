import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vezeeta/core/cache/cache_helper.dart';
import 'package:vezeeta/features/profile/data/user_model.dart';
import 'package:vezeeta/features/profile/logic/profile_events.dart';
import 'package:vezeeta/features/profile/logic/profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Dio dio;

  ProfileBloc(this.dio) : super(ProfileInitial()) {

    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final token = CacheHelper.getToken() ?? '';

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

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final token = CacheHelper.getToken() ?? '';

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

    on<LogoutEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final token = CacheHelper.getToken() ?? '';

        await dio.post(
          'https://vcare.integration25.com/api/auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        await CacheHelper.clearToken();
        await CacheHelper.remove('saved_email');
        await CacheHelper.setBool('remember_me', false);

        emit(ProfileLoggedOut());
      } catch (e) {
        await CacheHelper.clearToken();
        await CacheHelper.remove('saved_email');
        await CacheHelper.setBool('remember_me', false);
        emit(ProfileLoggedOut());
      }
    });
  }
}
