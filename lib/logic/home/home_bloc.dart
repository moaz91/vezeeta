import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/home_model.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Dio dio;

  HomeBloc(this.dio) : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        final response = await dio.get(
          'https://vcare.integration25.com/api/home/index',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        if (response.statusCode == 200) {
          final homeResponse = HomeResponse.fromJson(response.data);
          emit(HomeLoaded(homeResponse));
        } else {
          emit(HomeError('Failed to load home data'));
        }
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}