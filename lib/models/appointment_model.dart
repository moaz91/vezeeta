class AppointmentModel {
  final int id;
  final String notes;
  final String status;
  final String appointmentTime;
  final int appointmentPrice;

  AppointmentModel({
    required this.id,
    required this.notes,
    required this.status,
    required this.appointmentTime,
    required this.appointmentPrice,
  });

  // Real API response structure:
  // { id, doctor: {...}, patient: {...}, appointment_time, status, notes, appointment_price }
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? 0,
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      appointmentTime: json['appointment_time'] ?? '',
      appointmentPrice: json['appointment_price'] ?? 0,
    );
  }
}