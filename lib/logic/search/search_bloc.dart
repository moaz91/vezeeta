import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/doctor_model.dart';
import 'search_events.dart';
import 'search_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Dio dio;

  SearchBloc(this.dio) : super(SearchInitial()) {
    on<SearchDoctors>((event, emit) async {
      if (event.name.trim().isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        final response = await dio.get(
          'https://vcare.integration25.com/api/doctor/doctor-search',
          queryParameters: {'name': event.name},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          final List<Doctor> doctors = List<Doctor>.from(
            (response.data['data'] ?? []).map((d) => Doctor.fromJson(d)),
          );
          emit(SearchLoaded(doctors));
        } else {
          emit(SearchError('Search failed'));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}