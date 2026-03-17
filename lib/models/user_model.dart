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
    // API returns data as a List: { data: [{...}] }
    Map<String, dynamic> data;
    final raw = json['data'];
    if (raw is List && raw.isNotEmpty) {
      data = Map<String, dynamic>.from(raw[0]);
    } else if (raw is Map) {
      data = Map<String, dynamic>.from(raw);
    } else {
      data = json;
    }

    // gender can be int (0/1) or string ("male"/"female"/"0"/"1")
    final rawGender = data['gender'];
    String gender;
    if (rawGender == null) {
      gender = '0';
    } else if (rawGender is int) {
      gender = rawGender.toString();
    } else {
      final g = rawGender.toString().toLowerCase();
      gender = (g == 'female') ? '1' : (g == 'male') ? '0' : g;
    }

    return UserModel(
      id: data['id'] ?? 0,
      name: data['name']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      phone: data['phone']?.toString() ?? '',
      gender: gender,
    );
  }
}