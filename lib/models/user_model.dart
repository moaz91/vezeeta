class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String gender;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // API wraps in 'data' key: { data: { id, name, email, phone, gender } }
    final data = json['data'] ?? json;
    return UserModel(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      gender: data['gender']?.toString() ?? '',
    );
  }
}
