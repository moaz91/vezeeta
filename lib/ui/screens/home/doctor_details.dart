import 'package:flutter/material.dart';
import '../../../models/doctor_model.dart';

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

  String get doctorName => widget.doctor.name;

  final String doctorSpeciality = "General";
  final String doctorHospital = "RSUD Gatot Subroto";
  final double doctorRating = 4.8;
  final int doctorReviews = 4279;
  final String doctorImage = "assets/rec.png";

  final String aboutMe =
      "Dr. Jenny Watson is the top most Immunologists specialist in Christ Hospital at London. She achieved several awards for her wonderful contribution in medical field. She is available for private consultation.";

  final String workingTime = "Monday - Friday, 08.00 AM - 20.00 PM";
  final String str = "4726482464";
  final String practicePlace = "Cairo, Egypt";

  final List<WorkExperienceModel> experiences = [
    WorkExperienceModel(hospital: "RSPAD Gatot Soebroto", period: "2017 - sekarang"),
    WorkExperienceModel(hospital: "RS Siloam Jakarta", period: "2013 - 2017"),
  ];

  final List<ReviewModel> reviews = [
    ReviewModel(
      name: "Jane Cooper",
      avatar: "assets/rec.png",
      stars: 5,
      comment:
      "As someone who lives in a remote area with limited access to healthcare, this telemedicine app has been a game changer for me. I can easily schedule virtual appointments with doctors and get the care I need without having to travel long distances.",
      date: "Today",
    ),
    ReviewModel(
      name: "Robert Fox",
      avatar: "assets/rec.png",
      stars: 5,
      comment:
      "I was initially skeptical about using a telemedicine app but this app has exceeded my expectations. The doctors are highly qualified and provide excellent care.",
      date: "Today",
    ),
    ReviewModel(
      name: "Jacob Jones",
      avatar: "assets/rec.png",
      stars: 5,
      comment:
      "Great experience! The doctor was very attentive and professional. Highly recommend this service to everyone.",
      date: "Today",
    ),
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

  String _formatReviews(int count) {
    if (count >= 1000) return "${(count / 1000).toStringAsFixed(1)}k";
    return count.toString();
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
              border: Border.all(color: const Color.fromRGBO(237, 237, 237, 1)),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    doctorImage,
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
                      Text(
                        doctorName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$doctorSpeciality  |  $doctorHospital",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(117, 117, 117, 1)),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color.fromRGBO(255, 203, 0, 1),
                              size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "$doctorRating (${_formatReviews(doctorReviews)} reviews)",
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
          TabBar(
            controller: _tabController,
            labelColor: const Color.fromRGBO(36, 124, 255, 1),
            unselectedLabelColor: const Color.fromRGBO(117, 117, 117, 1),
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14),
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14),
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(36, 124, 255, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text(
              "Make An Appointment",
              style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const Text("STR",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          Text(
            str,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(97, 97, 97, 1)),
          ),
          const SizedBox(height: 20),
          const Text("Pengalaman Praktik",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(height: 8),
          ...experiences.map((exp) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.hospital,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(97, 97, 97, 1)),
                ),
                Text(
                  exp.period,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(150, 150, 150, 1)),
                ),
                const SizedBox(height: 8),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildLocationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              color: const Color.fromRGBO(220, 230, 240, 1),
              child: Stack(
                children: [
                  Image.network(
                    "https://maps.googleapis.com/maps/api/staticmap?center=Cairo,Egypt&zoom=14&size=600x300&maptype=roadmap&markers=color:red%7CCairo,Egypt&key=YOUR_KEY",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color.fromRGBO(224, 235, 248, 1),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.red, size: 40),
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
            ),
          ),
        ],
      ),
    );
  }

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
                  child: Text(
                    review.name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                Text(
                  review.date,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(150, 150, 150, 1)),
                ),
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