// Model for GET /specialization/index
// Returns just id and name — no doctors list
class SpecializationItem {
  final int id;
  final String name;

  SpecializationItem({required this.id, required this.name});

  factory SpecializationItem.fromJson(Map<String, dynamic> json) {
    return SpecializationItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
