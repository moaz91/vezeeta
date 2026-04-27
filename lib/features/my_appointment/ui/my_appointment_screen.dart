import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vezeeta/features/appointment/logic/appointment_bloc.dart';
import 'package:vezeeta/features/appointment/logic/appointment_events.dart';
import 'package:vezeeta/features/appointment/logic/appointment_states.dart';
import 'package:vezeeta/features/appointment/data/appointment_model.dart';
import 'package:vezeeta/features/my_appointment/ui/reschedule_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Fetch appointments when screen opens
      create: (_) => AppointmentBloc(Dio())..add(FetchAppointments()),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left,
                color: Colors.black, size: 28),
          ),
          title: const Text("My Appointment",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black)),
          centerTitle: true,
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.search, color: Colors.black, size: 24),
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
                unselectedLabelColor:
                    const Color.fromRGBO(150, 150, 150, 1),
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
              child: BlocBuilder<AppointmentBloc, AppointmentState>(
                builder: (context, state) {
                  if (state is AppointmentLoading ||
                      state is AppointmentInitial) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (state is AppointmentError) {
                    return Center(
                      child: Text(state.message,
                          style: const TextStyle(color: Colors.red)),
                    );
                  }

                  if (state is AppointmentsLoaded) {
                    // Filter by status for each tab
                    // API status values: "pending" = upcoming, "completed", "cancelled"
                    final upcoming = state.appointments
                        .where((a) => a.isPending)
                        .toList();
                    final completed = state.appointments
                        .where((a) => a.isCompleted)
                        .toList();
                    final cancelled = state.appointments
                        .where((a) => a.isCancelled)
                        .toList();

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildUpcomingTab(upcoming),
                        _buildStatusTab(completed, isCompleted: true),
                        _buildStatusTab(cancelled, isCompleted: false),
                      ],
                    );
                  }

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _emptyState("No upcoming appointments"),
                      _emptyState("No completed appointments"),
                      _emptyState("No cancelled appointments"),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Upcoming tab ──────────────────────────────────────────────────────────
  Widget _buildUpcomingTab(List<AppointmentModel> appointments) {
    if (appointments.isEmpty) {
      return _emptyState("No upcoming appointments");
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final apt = appointments[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: const Color.fromRGBO(237, 237, 237, 1)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Doctor photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      apt.doctor.photo,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 56,
                        height: 56,
                        color:
                            const Color.fromRGBO(244, 248, 255, 1),
                        child:
                            const Icon(Icons.person, size: 28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(apt.doctor.name,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                        const SizedBox(height: 4),
                        // Notes = appointment type (In Person, Video Call etc)
                        Text(apt.notes,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(
                                    117, 117, 117, 1))),
                        const SizedBox(height: 4),
                        Text(apt.appointmentTime,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(
                                    117, 117, 117, 1))),
                      ],
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                          const Color.fromRGBO(232, 243, 255, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.chat_bubble_outline,
                        color: Color.fromRGBO(36, 124, 255, 1),
                        size: 18),
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
                            borderRadius:
                                BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12),
                      ),
                      child: const Text("Cancel Appointment",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(
                                  36, 124, 255, 1))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const RescheduleScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(36, 124, 255, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10)),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12),
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

  // ── Completed & Cancelled tabs ────────────────────────────────────────────
  Widget _buildStatusTab(
      List<AppointmentModel> appointments,
      {required bool isCompleted}) {
    if (appointments.isEmpty) {
      return _emptyState(isCompleted
          ? "No completed appointments"
          : "No cancelled appointments");
    }

    final statusLabel =
        isCompleted ? "Appointment done" : "Appointment cancelled";
    final statusColor = isCompleted
        ? const Color.fromRGBO(34, 197, 94, 1)
        : const Color.fromRGBO(239, 68, 68, 1);

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final apt = appointments[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: const Color.fromRGBO(237, 237, 237, 1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Status label + datetime + more icon (inside container) ──
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(16, 14, 12, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(statusLabel,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: statusColor)),
                          const SizedBox(height: 4),
                          Text(apt.appointmentTime,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(
                                      150, 150, 150, 1))),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_vert,
                        color: Color.fromRGBO(150, 150, 150, 1),
                        size: 20),
                  ],
                ),
              ),

              // ── Horizontal divider ──────────────────────────────────
              const Divider(height: 1, color: Color(0xFFEEEEEE)),

              // ── Doctor info ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        apt.doctor.photo,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 64,
                          height: 64,
                          color: const Color.fromRGBO(
                              244, 248, 255, 1),
                          child: const Icon(Icons.person,
                              size: 32),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(apt.doctor.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          const SizedBox(height: 4),
                          Text(apt.doctor.specialization,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(
                                      117, 117, 117, 1))),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Color.fromRGBO(
                                      255, 203, 0, 1),
                                  size: 14),
                              const SizedBox(width: 4),
                              Text(apt.doctor.degree,
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

  Widget _emptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined,
              size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(message,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
