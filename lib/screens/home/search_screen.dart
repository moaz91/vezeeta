import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vezeeta/screens/home/recommendation_doctor_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  String _selectedSpeciality = 'All';
  String _selectedRating = 'All';
  List<String> _recentSearches = [];

  static const _prefKey = 'recent_searches';
  static const _maxRecent = 10;

  final List<String> specialities = [
    'All', 'General', 'ENT', 'Pediatric', 'Urologist',
    'Dentistry', 'Intestine', 'Histologist', 'Hepatology',
    'Cardiologist', 'Neurologic', 'Pulmonary', 'Optometry',
  ];

  final List<String> ratings = ['All', '5', '4', '3', '2'];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList(_prefKey) ?? [];
    });
  }

  Future<void> _saveRecentSearch(String query) async {
    if (query.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_prefKey) ?? [];
    list.remove(query);
    list.insert(0, query);
    if (list.length > _maxRecent) list.removeLast();
    await prefs.setStringList(_prefKey, list);
    setState(() => _recentSearches = list);
  }

  Future<void> _removeRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_prefKey) ?? [];
    list.remove(query);
    await prefs.setStringList(_prefKey, list);
    setState(() => _recentSearches = list);
  }

  Future<void> _clearAllRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefKey);
    setState(() => _recentSearches = []);
  }

  void _submitSearch(String query) {
    if (query.trim().isEmpty) return;
    _saveRecentSearch(query.trim());
    setState(() => _query = query.trim());
  }

  List<DoctorModel> get _filteredDoctors {
    if (_query.isEmpty) return [];
    return allDoctors.where((doc) {
      final matchesSearch =
          doc.name.toLowerCase().contains(_query.toLowerCase()) ||
              doc.speciality.toLowerCase().contains(_query.toLowerCase()) ||
              doc.hospital.toLowerCase().contains(_query.toLowerCase());
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
      builder: (_) => _FilterSheet(
        initialSpeciality: _selectedSpeciality,
        initialRating: _selectedRating,
        specialities: specialities,
        ratings: ratings,
      ),
    );
    if (result != null) {
      setState(() {
        _selectedSpeciality = result['speciality']!;
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
    final results = _filteredDoctors;
    final showResults = _query.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      onChanged: (val) => setState(() => _query = val),
                      onSubmitted: _submitSearch,
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
          ),

          if (showResults) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: specialities.map((s) {
                    final isSelected = _selectedSpeciality == s;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedSpeciality = s),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2979FF) : const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            s,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${results.length} founds",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          Expanded(
            child: showResults
                ? results.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  Text("No results found",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: results.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: Color(0xFFF2F2F2),
                indent: 90,
              ),
              itemBuilder: (context, index) {
                final doc = results[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          doc.image,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doc.name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            const SizedBox(height: 4),
                            Text(
                              "${doc.speciality}  |  ${doc.hospital}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(117, 117, 117, 1)),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Color.fromRGBO(255, 203, 0, 1), size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "${doc.rating} (${_formatReviews(doc.reviews)} reviews)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(66, 66, 66, 1)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
                : _recentSearches.isEmpty
                ? Center(
              child: Text("No recent searches",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey.shade400)),
            )
                : Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Recent Search",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      GestureDetector(
                        onTap: _clearAllRecentSearches,
                        child: Text("Clear All History",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(36, 124, 255, 1))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _recentSearches.length,
                      itemBuilder: (context, index) {
                        final item = _recentSearches[index];
                        return GestureDetector(
                          onTap: () {
                            _controller.text = item;
                            _submitSearch(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Icon(Icons.access_time,
                                    size: 20,
                                    color: Colors.grey.shade400),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(item,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(66, 66, 66, 1))),
                                ),
                                GestureDetector(
                                  onTap: () => _removeRecentSearch(item),
                                  child: Icon(Icons.close,
                                      size: 18,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  final String initialSpeciality;
  final String initialRating;
  final List<String> specialities;
  final List<String> ratings;

  const _FilterSheet({
    required this.initialSpeciality,
    required this.initialRating,
    required this.specialities,
    required this.ratings,
  });

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String selectedSpeciality;
  late String selectedRating;

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
            child: Text('Sort By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFEEEEEE)),
          const SizedBox(height: 20),
          const Text('Speciality',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.specialities.map((s) {
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
                      child: Text(s,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          )),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 28),
          const Text('Rating',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.ratings.map((r) {
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
                          Icon(Icons.star,
                              size: 16,
                              color: isSelected ? Colors.white : Colors.grey.shade400),
                          const SizedBox(width: 6),
                          Text(r,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              )),
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
                'speciality': selectedSpeciality,
                'rating': selectedRating,
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2979FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text('Done',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}