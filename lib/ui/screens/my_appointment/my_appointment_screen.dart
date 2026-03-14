import 'package:flutter/material.dart';
import 'package:vezeeta/ui/screens/my_appointment/reschedule_screen.dart';

class AppointmentUIModel {
  final String doctorName;
  final String doctorImage;
  final String specialty;
  final String date;
  final String time;
  final double rating;
  final int reviews;

  AppointmentUIModel({
    required this.doctorName,
    required this.doctorImage,
    required this.specialty,
    required this.date,
    required this.time,
    required this.rating,
    required this.reviews,
  });
}

final List<AppointmentUIModel> _appointments = [
  AppointmentUIModel(
    doctorName: "Dr. Randy Wigham",
    doctorImage: "assets/rec.png",
    specialty: "General Medical Checkup",
    date: "Wed, 17 May",
    time: "08.30 AM",
    rating: 4.8,
    reviews: 4279,
  ),
  AppointmentUIModel(
    doctorName: "Dr. Jack Sulivan",
    doctorImage: "assets/rec.png",
    specialty: "General Medical Checkup",
    date: "Wed, 17 May",
    time: "08.30 AM",
    rating: 4.8,
    reviews: 4279,
  ),
  AppointmentUIModel(
    doctorName: "Drg. Hanna Stanton",
    doctorImage: "assets/rec.png",
    specialty: "General Medical Checkup",
    date: "Wed, 17 May",
    time: "08.30 AM",
    rating: 4.8,
    reviews: 4279,
  ),
];

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
        ),
        title: const Text("My Appointment",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.search, color: Colors.black, size: 24),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: const Color.fromRGBO(36, 124, 255, 1),
              unselectedLabelColor: const Color.fromRGBO(150, 150, 150, 1),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14),
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14),
              indicatorColor: const Color.fromRGBO(36, 124, 255, 1),
              indicatorWeight: 2,
              tabs: const [
                Tab(text: "Upcoming"),
                Tab(text: "Completed"),
                Tab(text: "Cancelled"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUpcomingTab(),
                _buildStatusTab(isCompleted: true),
                _buildStatusTab(isCompleted: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Upcoming tab ──────────────────────────────────────────────────────────
  Widget _buildUpcomingTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final apt = _appointments[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border:
            Border.all(color: const Color.fromRGBO(237, 237, 237, 1)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(apt.doctorImage,
                        width: 56, height: 56, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(apt.doctorName,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                        const SizedBox(height: 4),
                        Text(apt.specialty,
                            style: const TextStyle(
                                fontSize: 12,
                                color:
                                Color.fromRGBO(117, 117, 117, 1))),
                        const SizedBox(height: 4),
                        Text("${apt.date}  |  ${apt.time}",
                            style: const TextStyle(
                                fontSize: 12,
                                color:
                                Color.fromRGBO(117, 117, 117, 1))),
                      ],
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(232, 243, 255, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.chat_bubble_outline,
                        color: Color.fromRGBO(36, 124, 255, 1), size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromRGBO(36, 124, 255, 1)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                        const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("Cancel Appointment",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(36, 124, 255, 1))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RescheduleScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color.fromRGBO(36, 124, 255, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                        padding:
                        const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("Reschedule",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Completed & Cancelled tabs — same structure, different label/color ────
  Widget _buildStatusTab({required bool isCompleted}) {
    final statusLabel =
    isCompleted ? "Appointment done" : "Appointment cancelled";
    final statusColor = isCompleted
        ? const Color.fromRGBO(34, 197, 94, 1)
        : const Color.fromRGBO(239, 68, 68, 1);

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final apt = _appointments[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border:
            Border.all(color: const Color.fromRGBO(237, 237, 237, 1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Status label + date/time + more icon — INSIDE container ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(statusLabel,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: statusColor)),
                          const SizedBox(height: 4),
                          Text("${apt.date}  |  ${apt.time}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                  Color.fromRGBO(150, 150, 150, 1))),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_vert,
                        color: Color.fromRGBO(150, 150, 150, 1), size: 20),
                  ],
                ),
              ),

              // ── Horizontal divider ────────────────────────────────────
              const Divider(height: 1, color: Color(0xFFEEEEEE)),

              // ── Doctor info below the divider ─────────────────────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(apt.doctorImage,
                          width: 64, height: 64, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(apt.doctorName,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          const SizedBox(height: 4),
                          Text(apt.specialty,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(
                                      117, 117, 117, 1))),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color:
                                  Color.fromRGBO(255, 203, 0, 1),
                                  size: 14),
                              const SizedBox(width: 4),
                              Text(
                                  "${apt.rating} (${_formatReviews(apt.reviews)} reviews)",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(
                                          66, 66, 66, 1))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

