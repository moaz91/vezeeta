import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/specialization_model.dart';
import 'specialization_events.dart';
import 'specialization_states.dart';

class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  final Dio dio;

  SpecializationBloc(this.dio) : super(SpecializationInitial()) {
    on<FetchAllSpecializations>((event, emit) async {
      emit(SpecializationLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        final response = await dio.get(
          'https://vcare.integration25.com/api/specialization/index',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode == 200) {
          final List<SpecializationItem> items = List<SpecializationItem>.from(
            (response.data['data'] ?? [])
                .map((s) => SpecializationItem.fromJson(s)),
          );
          emit(SpecializationLoaded(items));
        } else {
          emit(const SpecializationError('Failed to load specializations'));
        }
      } catch (e) {
        emit(SpecializationError(e.toString()));
      }
    });
  }
}
