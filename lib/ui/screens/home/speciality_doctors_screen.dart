import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/doctor_model.dart';
import '../../widgets/speciality_doctors_widget.dart';

// Receives specializationId and name
// Calls GET /specialization/show/{id} to fetch the doctors for that specialization
class SpecialityDoctorsScreen extends StatefulWidget {
  final int specializationId;
  final String specializationName;

  const SpecialityDoctorsScreen({
    super.key,
    required this.specializationId,
    required this.specializationName,
  });

  @override
  State<SpecialityDoctorsScreen> createState() =>
      _SpecialityDoctorsScreenState();
}

class _SpecialityDoctorsScreenState extends State<SpecialityDoctorsScreen> {
  List<Doctor> _doctors = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final dio = Dio();
      // GET /specialization/show/{id} returns the specialization with its doctors
      final response = await dio.get(
        'https://vcare.integration25.com/api/specialization/show/${widget.specializationId}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // Response structure: { data: { id, name, doctors: [...] } }
        final doctorsJson = response.data['data']['doctors'] ?? [];
        final doctors = List<Doctor>.from(
          doctorsJson.map((d) => Doctor.fromJson(d)),
        );
        setState(() {
          _doctors = doctors;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load doctors';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: const Color.fromRGBO(237, 237, 237, 1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chevron_left, color: Colors.black),
          ),
        ),
        title: Text(
          widget.specializationName,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(_error!,
                      style: const TextStyle(color: Colors.red)))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "${_doctors.length} doctors found",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SpecialityDoctorsWidget(
                            doctors: _doctors,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
