import 'package:flutter/material.dart';

class DoctorModel {
  final String name;
  final String speciality;
  final String hospital;
  final double rating;
  final int reviews;
  final String image;

  DoctorModel({
    required this.name,
    required this.speciality,
    required this.hospital,
    required this.rating,
    required this.reviews,
    required this.image,
  });
}

final List<DoctorModel> allDoctors = [
  DoctorModel(name: "Dr. Randy Wigham",   speciality: "General",      hospital: "RSUD Gatot Subroto",  rating: 4.8, reviews: 4279, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Sarah Connor",   speciality: "ENT",          hospital: "RS Siloam",           rating: 4.7, reviews: 3120, image: "assets/rec.png"),
  DoctorModel(name: "Dr. James Patel",    speciality: "Pediatric",    hospital: "RS Pondok Indah",     rating: 4.9, reviews: 5200, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Linda Hoffman",  speciality: "Urologist",    hospital: "RSCM",                rating: 4.5, reviews: 2100, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Kevin Tan",      speciality: "Dentistry",    hospital: "RS Premier Bintaro",  rating: 4.6, reviews: 1890, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Mia Kurniawan", speciality: "Intestine",    hospital: "RS Medistra",         rating: 4.4, reviews: 980,  image: "assets/rec.png"),
  DoctorModel(name: "Dr. Robert Santoso", speciality: "Histologist",  hospital: "RS Carolus",          rating: 4.3, reviews: 760,  image: "assets/rec.png"),
  DoctorModel(name: "Dr. Ayu Lestari",   speciality: "Hepatology",   hospital: "RS Persahabatan",     rating: 4.7, reviews: 3400, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Ahmad Fauzi",   speciality: "Cardiologist", hospital: "RSUP Fatmawati",      rating: 4.9, reviews: 6100, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Nina Pratiwi",  speciality: "Neurologic",   hospital: "RS Hermina",          rating: 4.6, reviews: 2750, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Budi Hartono",  speciality: "Pulmonary",    hospital: "RSUD Tarakan",        rating: 4.5, reviews: 1560, image: "assets/rec.png"),
  DoctorModel(name: "Dr. Dewi Susanti",  speciality: "Optometry",    hospital: "RS Mata Aini",        rating: 4.8, reviews: 3890, image: "assets/rec.png"),
];

class RecommendationDoctorScreen extends StatefulWidget {
  const RecommendationDoctorScreen({super.key});

  @override
  State<RecommendationDoctorScreen> createState() =>
      _RecommendationDoctorScreenState();
}

class _RecommendationDoctorScreenState
    extends State<RecommendationDoctorScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSpeciality = 'All';
  String _selectedRating = 'All';

  List<DoctorModel> get _filteredDoctors {
    return allDoctors.where((doc) {
      final matchesSearch =
          doc.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              doc.speciality.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              doc.hospital.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesSpeciality =
          _selectedSpeciality == 'All' || doc.speciality == _selectedSpeciality;

      final matchesRating =
          _selectedRating == 'All' || doc.rating >= double.parse(_selectedRating);

      return matchesSearch && matchesSpeciality && matchesRating;
    }).toList();
  }

  bool get _isFiltered => _selectedSpeciality != 'All' || _selectedRating != 'All';

  void _showFilterSheet() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        initialSpeciality: _selectedSpeciality,
        initialRating: _selectedRating,
      ),
    );
    if (result != null) {
      setState(() {
        _selectedSpeciality = result['specialization']!;
        _selectedRating = result['rating']!;
      });
    }
  }

  String _formatReviews(int reviews) {
    if (reviews >= 1000) return "${(reviews / 1000).toStringAsFixed(1)}k";
    return reviews.toString();
  }

  @override
  Widget build(BuildContext context) {
    final doctors = _filteredDoctors;

    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        title: Text(
          "Recommendation Doctor",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Color.fromRGBO(237, 237, 237, 1)),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.more_horiz, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                        prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 22),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _showFilterSheet,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _isFiltered ? const Color(0xFF2979FF) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color.fromRGBO(237, 237, 237, 1), width: 1),
                    ),
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: _isFiltered ? Colors.white : Colors.grey.shade600,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: doctors.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      "No doctors found",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: doctors.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  final doc = doctors[index];
                  return Container(
                    height: 126,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(doc.image),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                doc.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    doc.speciality,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "|",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      doc.hospital,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromRGBO(255, 203, 0, 1),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    doc.rating.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(66, 66, 66, 1),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "(${_formatReviews(doc.reviews)} reviews)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(66, 66, 66, 1),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final String initialSpeciality;
  final String initialRating;

  const FilterBottomSheet({
    super.key,
    required this.initialSpeciality,
    required this.initialRating,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String selectedSpeciality;
  late String selectedRating;

  final List<String> specialities = [
    'All', 'General', 'ENT', 'Pediatric', 'Urologist',
    'Dentistry', 'Intestine', 'Histologist', 'Hepatology',
    'Cardiologist', 'Neurologic', 'Pulmonary', 'Optometry',
  ];

  final List<String> ratings = ['All', '5', '4', '3', '2'];

  @override
  void initState() {
    super.initState();
    selectedSpeciality = widget.initialSpeciality;
    selectedRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Sort By',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFEEEEEE)),
          const SizedBox(height: 20),
          const Text(
            'Speciality',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: specialities.map((s) {
                final isSelected = selectedSpeciality == s;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedSpeciality = s),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2979FF) : const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        s,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Rating',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ratings.map((r) {
                final isSelected = selectedRating == r;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedRating = r),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2979FF) : const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: isSelected ? Colors.white : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            r,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, {
                'specialization': selectedSpeciality,
                'rating': selectedRating,
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2979FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}