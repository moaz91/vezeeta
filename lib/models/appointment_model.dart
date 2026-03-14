class AppointmentModel {
  final int id;
  final int doctorId;
  final String notes;
  final String status;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.notes,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
