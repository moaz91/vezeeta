import 'package:vezeeta/features/home/data/doctor_model.dart';

class HomeSpecialization {
  final int id;
  final String name;
  final List<Doctor> doctors;

  HomeSpecialization({
    required this.id,
    required this.name,
    required this.doctors,
  });

  factory HomeSpecialization.fromJson(Map<String, dynamic> json) {
    return HomeSpecialization(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      doctors: List<Doctor>.from(
        (json['doctors'] ?? []).map((d) => Doctor.fromJson(d)),
      ),
    );
  }
}

class HomeResponse {
  final List<HomeSpecialization> specializations;

  HomeResponse({required this.specializations});

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      specializations: List<HomeSpecialization>.from(
        (json['data'] ?? []).map((s) => HomeSpecialization.fromJson(s)),
      ),
    );
  }
}