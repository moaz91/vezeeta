import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vezeeta/features/appointment/logic/appointment_bloc.dart';
import 'package:vezeeta/features/appointment/logic/appointment_events.dart';
import 'package:vezeeta/features/appointment/logic/appointment_states.dart';
import 'package:vezeeta/features/home/data/doctor_model.dart';
import 'package:vezeeta/features/appointment/ui/booking_confirmed_screen.dart';

class BookSummaryScreen extends StatelessWidget {
  final Doctor doctor;
  final String selectedDate;   // human-readable: "Wednesday, 08 May 2024"
  final String selectedTime;   // human-readable: "08.30 AM"
  final String appointmentType;
  final String paymentMethod;
  // Raw date values needed to build the API start_time format
  final DateTime rawDate;

  const BookSummaryScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.appointmentType,
    required this.paymentMethod,
    required this.rawDate,
  });

  // Converts rawDate + selectedTime to "YYYY-MM-DD HH:MM" format for the API
  // e.g. "2024-05-08 08:30"
  String get _apiStartTime {
    final y = rawDate.year.toString().padLeft(4, '0');
    final m = rawDate.month.toString().padLeft(2, '0');
    final d = rawDate.day.toString().padLeft(2, '0');

    // Parse the time string "08.30 AM" → "08:30"
    final timeParts = selectedTime.replaceAll(' AM', '').replaceAll(' PM', '').split('.');
    var hour = int.parse(timeParts[0]);
    final minute = timeParts.length > 1 ? timeParts[1].padLeft(2, '0') : '00';

    // Handle PM
    if (selectedTime.contains('PM') && hour != 12) hour += 12;
    if (selectedTime.contains('AM') && hour == 12) hour = 0;

    final hStr = hour.toString().padLeft(2, '0');
    return "$y-$m-$d $hStr:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentBloc(Dio()),
      child: BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentBooked) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BookingConfirmedScreen(
                  doctor: doctor,
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                  appointmentType: appointmentType,
                ),
              ),
            );
          } else if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AppointmentLoading;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.chevron_left,
                    color: Colors.black, size: 28),
              ),
              title: const Text("Book Appointment",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildStepIndicator(currentStep: 3),
                  const SizedBox(height: 28),

                  // ── Booking Information ───────────────────────────────
                  const Text("Booking Information",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  const SizedBox(height: 16),

                  _infoRow(
                    icon: Icons.calendar_today_outlined,
                    title: "Date & Time",
                    value: "$selectedDate\n$selectedTime",
                  ),
                  const Divider(color: Color(0xFFF2F2F2)),
                  _infoRow(
                    icon: Icons.medical_services_outlined,
                    title: "Appointment Type",
                    value: appointmentType,
                  ),

                  const SizedBox(height: 24),

                  // ── Doctor Information ────────────────────────────────
                  const Text("Doctor Information",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(250, 250, 250, 1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            doctor.photo,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 56,
                              height: 56,
                              color:
                                  const Color.fromRGBO(244, 248, 255, 1),
                              child: const Icon(Icons.person, size: 30),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doctor.name,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                              const SizedBox(height: 4),
                              Text(
                                "${doctor.specialization.name}  |  ${doctor.city.name}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(
                                        117, 117, 117, 1)),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Color.fromRGBO(
                                          255, 203, 0, 1),
                                      size: 14),
                                  const SizedBox(width: 4),
                                  Text(doctor.degree,
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

                  const SizedBox(height: 24),

                  // ── Payment Information ───────────────────────────────
                  const Text("Payment Information",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const Icon(Icons.payment,
                          color: Color.fromRGBO(36, 124, 255, 1)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(paymentMethod,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(
                                    36, 124, 255, 1)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text("Change",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(
                                      36, 124, 255, 1))),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Payment breakdown ─────────────────────────────────
                  const Text("Payment Info",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  const SizedBox(height: 16),

                  _paymentRow("Subtotal", "\$${doctor.appointPrice}"),
                  const SizedBox(height: 8),
                  _paymentRow("Tax",
                      "\$${(doctor.appointPrice * 0.05).round()}"),
                  const Divider(color: Color(0xFFEEEEEE)),
                  _paymentRow(
                    "Payment Total",
                    "\$${doctor.appointPrice + (doctor.appointPrice * 0.05).round()}",
                    bold: true,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<AppointmentBloc>().add(
                                BookAppointment(
                                  doctorId: doctor.id,
                                  startTime: _apiStartTime,
                                  notes: appointmentType,
                                ),
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(36, 124, 255, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Text("Book Now",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(232, 243, 255, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                color: const Color.fromRGBO(36, 124, 255, 1), size: 20),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(117, 117, 117, 1))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                color: bold
                    ? Colors.black
                    : const Color.fromRGBO(117, 117, 117, 1))),
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                color: Colors.black)),
      ],
    );
  }
}

Widget _buildStepIndicator({required int currentStep}) {
  final steps = ["Date & Time", "Payment", "Summary"];
  return Row(
    children: List.generate(steps.length * 2 - 1, (i) {
      if (i.isOdd) {
        final stepIndex = i ~/ 2;
        final isDone = currentStep > stepIndex + 1;
        return Expanded(
          child: Container(
            height: 2,
            color: isDone
                ? const Color.fromRGBO(36, 124, 255, 1)
                : const Color.fromRGBO(220, 220, 220, 1),
          ),
        );
      }
      final stepIndex = i ~/ 2;
      final isActive = currentStep == stepIndex + 1;
      final isDone = currentStep > stepIndex + 1;
      return Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive || isDone
                  ? const Color.fromRGBO(36, 124, 255, 1)
                  : const Color.fromRGBO(220, 220, 220, 1),
            ),
            child: Center(
              child: isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text("${stepIndex + 1}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? Colors.white
                              : const Color.fromRGBO(150, 150, 150, 1))),
            ),
          ),
          const SizedBox(height: 4),
          Text(steps[stepIndex],
              style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? const Color.fromRGBO(36, 124, 255, 1)
                      : const Color.fromRGBO(150, 150, 150, 1))),
        ],
      );
    }),
  );
}
