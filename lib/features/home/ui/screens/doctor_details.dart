import 'package:flutter/material.dart';
import 'package:vezeeta/features/home/data/doctor_model.dart';
import 'package:vezeeta/features/appointment/ui/book_appointment_screen.dart';

// Reviews and WorkExperience stay static — not in the API
class ReviewModel {
  final String name;
  final String avatar;
  final int stars;
  final String comment;
  final String date;

  ReviewModel({
    required this.name,
    required this.avatar,
    required this.stars,
    required this.comment,
    required this.date,
  });
}

class WorkExperienceModel {
  final String hospital;
  final String period;
  WorkExperienceModel({required this.hospital, required this.period});
}

class DoctorDetails extends StatefulWidget {
  final Doctor doctor;

  const DoctorDetails({super.key, required this.doctor});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ── All data comes from widget.doctor ──────────────────────────────────────

  // AppBar and header
  String get doctorName => widget.doctor.name;

  // Specialization name from the nested object
  String get doctorSpeciality => widget.doctor.specialization.name;

  // Address from the API
  String get doctorAddress => widget.doctor.address;

  // City + Governrate as practice place
  String get practicePlace =>
      "${widget.doctor.city.name}, ${widget.doctor.city.governrate.name}";

  // Description from API
  String get aboutMe => widget.doctor.description.isNotEmpty
      ? widget.doctor.description
      : "No description available.";

  // Working time built from start_time and end_time
  String get workingTime =>
      "${widget.doctor.startTime} - ${widget.doctor.endTime}";

  // Degree used where STR/credential was shown
  String get degree => widget.doctor.degree;

  // Appointment price
  int get appointPrice => widget.doctor.appointPrice;

  // Doctor photo — network image with asset fallback
  String get photoUrl => widget.doctor.photo;

  // Static reviews — not in API
  final List<ReviewModel> reviews = [
    ReviewModel(
      name: "Jane Cooper",
      avatar: "assets/rec.png",
      stars: 5,
      comment:
          "As someone who lives in a remote area with limited access to healthcare, this telemedicine app has been a game changer for me.",
      date: "Today",
    ),
    ReviewModel(
      name: "Robert Fox",
      avatar: "assets/rec.png",
      stars: 5,
      comment:
          "I was initially skeptical about using a telemedicine app but this app has exceeded my expectations. The doctors are highly qualified.",
      date: "Today",
    ),
    ReviewModel(
      name: "Jacob Jones",
      avatar: "assets/rec.png",
      stars: 5,
      comment:
          "Great experience! The doctor was very attentive and professional. Highly recommend this service.",
      date: "Today",
    ),
  ];

  // Static work experience — not in API
  final List<WorkExperienceModel> experiences = [
    WorkExperienceModel(hospital: "City Medical Center", period: "2019 - Present"),
    WorkExperienceModel(hospital: "General Hospital", period: "2015 - 2019"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          doctorName,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(237, 237, 237, 1)),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.more_horiz, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                // ── Doctor photo — network with fallback ──────────────────
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    photoUrl,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(244, 248, 255, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person, size: 40),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor name
                      Text(
                        doctorName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      // Specialization | City
                      Text(
                        "$doctorSpeciality  |  ${widget.doctor.city.name}",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(117, 117, 117, 1)),
                      ),
                      const SizedBox(height: 6),
                      // Degree + Appointment price
                      Row(
                        children: [
                          const Icon(Icons.medical_services_outlined,
                              color: Color.fromRGBO(36, 124, 255, 1),
                              size: 14),
                          const SizedBox(width: 4),
                          Text(
                            "$degree  •  \$$appointPrice / visit",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(66, 66, 66, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(232, 243, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.chat_bubble_outline,
                      color: Color.fromRGBO(36, 124, 255, 1), size: 20),
                ),
              ],
            ),
          ),

          // ── Tab bar ───────────────────────────────────────────────────────
          TabBar(
            controller: _tabController,
            labelColor: const Color.fromRGBO(36, 124, 255, 1),
            unselectedLabelColor: const Color.fromRGBO(117, 117, 117, 1),
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            indicatorColor: const Color.fromRGBO(36, 124, 255, 1),
            indicatorWeight: 2,
            tabs: const [
              Tab(text: "About"),
              Tab(text: "Location"),
              Tab(text: "Reviews"),
            ],
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(),
                _buildLocationTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      BookAppointmentScreen(doctor: widget.doctor),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(36, 124, 255, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text(
              "Make An Appointment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  // ── About tab — uses API data ─────────────────────────────────────────────
  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About me — from doctor.description
          const Text("About me",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          Text(
            aboutMe,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(97, 97, 97, 1),
                height: 1.6),
          ),
          const SizedBox(height: 20),

          // Working time — from doctor.startTime + endTime
          const Text("Working Time",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          Text(
            workingTime,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(97, 97, 97, 1)),
          ),
          const SizedBox(height: 20),

          // Degree — from doctor.degree
          const Text("Degree",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          Text(
            degree,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(97, 97, 97, 1)),
          ),
          const SizedBox(height: 20),

          // Appointment price — from doctor.appointPrice
          const Text("Appointment Price",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          Text(
            "\$$appointPrice",
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(97, 97, 97, 1)),
          ),
          const SizedBox(height: 20),

          // Work experience — static (not in API)
          const Text("Work Experience",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          ...experiences.map((exp) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exp.hospital,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(97, 97, 97, 1))),
                    Text(exp.period,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(150, 150, 150, 1))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ── Location tab — uses city + governrate from API ────────────────────────
  Widget _buildLocationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full address from doctor.address
          const Text("Address",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          Text(
            doctorAddress,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(97, 97, 97, 1),
                height: 1.5),
          ),
          const SizedBox(height: 20),

          // Practice place — city + governrate
          const Text("Practice Place",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          Text(
            practicePlace,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(97, 97, 97, 1)),
          ),
          const SizedBox(height: 20),

          const Text("Location Map",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              height: 220,
              color: const Color.fromRGBO(224, 235, 248, 1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      practicePlace,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(66, 66, 66, 1)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Reviews tab — static data ─────────────────────────────────────────────
  Widget _buildReviewsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    review.avatar,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(review.name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                Text(review.date,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(150, 150, 150, 1))),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  Icons.star,
                  size: 18,
                  color: i < review.stars
                      ? const Color.fromRGBO(255, 203, 0, 1)
                      : const Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(97, 97, 97, 1),
                  height: 1.6),
            ),
          ],
        );
      },
    );
  }
}
