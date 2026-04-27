// Matches the real API response from POST /appointment/store and GET /appointment/index
// Response structure:
// { id, doctor: { id, name, photo, degree, specialization, city, appoint_price, ... },
//   patient: { id, name, ... }, appointment_time, appointment_end_time,
//   status, notes, appointment_price }

class AppointmentDoctor {
  final int id;
  final String name;
  final String photo;
  final String degree;
  final String specialization;
  final String city;
  final int appointPrice;

  AppointmentDoctor({
    required this.id,
    required this.name,
    required this.photo,
    required this.degree,
    required this.specialization,
    required this.city,
    required this.appointPrice,
  });

  factory AppointmentDoctor.fromJson(Map<String, dynamic> json) {
    return AppointmentDoctor(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      degree: json['degree'] ?? '',
      specialization: json['specialization']?['name'] ?? '',
      city: json['city']?['name'] ?? '',
      appointPrice: json['appoint_price'] ?? 0,
    );
  }
}

class AppointmentModel {
  final int id;
  final AppointmentDoctor doctor;
  final String appointmentTime;   // e.g. "Monday, March 16, 2026 10:00 AM"
  final String appointmentEndTime;
  final String status;             // "pending", "completed", "cancelled"
  final String notes;
  final int appointmentPrice;

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.status,
    required this.notes,
    required this.appointmentPrice,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? 0,
      doctor: AppointmentDoctor.fromJson(json['doctor'] ?? {}),
      appointmentTime: json['appointment_time'] ?? '',
      appointmentEndTime: json['appointment_end_time'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      appointmentPrice: json['appointment_price'] ?? 0,
    );
  }

  // Helper getters for display
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
  bool get isPending => status == 'pending';
}
