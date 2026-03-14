import 'package:flutter/material.dart';
import '../../../models/doctor_model.dart';
import 'book_payment_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  // Selected date index in the horizontal date picker
  int _selectedDateIndex = 2;

  // Selected time slot
  String? _selectedTime;

  // Appointment type: 0 = In Person, 1 = Video Call, 2 = Phone Call
  int _selectedType = 0;

  // Generate the next 7 days for the date picker
  final List<DateTime> _dates = List.generate(
    7,
        (i) => DateTime.now().add(Duration(days: i)),
  );

  final List<String> _times = [
    "08.00 AM", "08.30 AM",
    "09.00 AM", "09.30 AM",
    "10.00 AM", "11.00 AM",
  ];

  final List<Map<String, dynamic>> _appointmentTypes = [
    {'label': 'In Person',  'icon': Icons.people_outline},
    {'label': 'Video Call', 'icon': Icons.videocam_outlined},
    {'label': 'Phone Call', 'icon': Icons.phone_outlined},
  ];

  String get _selectedDateStr {
    final d = _dates[_selectedDateIndex];
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    return "${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]} ${d.year}";
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
          child: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
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

            // ── Step indicator ────────────────────────────────────────────
            _buildStepIndicator(currentStep: 1),

            const SizedBox(height: 28),

            // ── Select Date ───────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Select Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                Text("Set Manual",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(36, 124, 255, 1))),
              ],
            ),

            const SizedBox(height: 16),

            // ── Horizontal date scroller ──────────────────────────────────
            Row(
              children: [
                const Icon(Icons.chevron_left,
                    color: Color.fromRGBO(180, 180, 180, 1)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(_dates.length > 5 ? 5 : _dates.length, (i) {
                      final date = _dates[i];
                      final isSelected = _selectedDateIndex == i;
                      const dayNames = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                      final dayName = dayNames[date.weekday - 1];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDateIndex = i),
                        child: Container(
                          width: 52,
                          height: 64,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromRGBO(36, 124, 255, 1)
                                : const Color.fromRGBO(245, 248, 255, 1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(dayName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Colors.white70
                                          : const Color.fromRGBO(
                                          150, 150, 150, 1))),
                              const SizedBox(height: 4),
                              Text("${date.day}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black)),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: Color.fromRGBO(180, 180, 180, 1)),
              ],
            ),

            const SizedBox(height: 28),

            // ── Available time ────────────────────────────────────────────
            const Text("Available time",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _times.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3.2,
              ),
              itemBuilder: (_, i) {
                final time = _times[i];
                final isSelected = _selectedTime == time;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = time),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromRGBO(36, 124, 255, 1)
                          : const Color.fromRGBO(245, 248, 255, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(time,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color.fromRGBO(100, 100, 100, 1))),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            // ── Appointment type ──────────────────────────────────────────
            const Text("Appointment Type",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(height: 16),

            ..._appointmentTypes.asMap().entries.map((entry) {
              final i = entry.key;
              final type = entry.value;
              final isSelected = _selectedType == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedType = i),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? const Color.fromRGBO(36, 124, 255, 1)
                          : const Color.fromRGBO(230, 230, 230, 1),
                      width: isSelected ? 1.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(232, 243, 255, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(type['icon'] as IconData,
                            color: const Color.fromRGBO(36, 124, 255, 1),
                            size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(type['label'] as String,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      Radio<int>(
                        value: i,
                        groupValue: _selectedType,
                        onChanged: (v) =>
                            setState(() => _selectedType = v!),
                        activeColor:
                        const Color.fromRGBO(36, 124, 255, 1),
                      ),
                    ],
                  ),
                ),
              );
            }),

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
            onPressed: _selectedTime == null
                ? null
                : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookPaymentScreen(
                    doctor: widget.doctor,
                    selectedDate: _selectedDateStr,
                    selectedTime: _selectedTime!,
                    appointmentType:
                    _appointmentTypes[_selectedType]['label']
                    as String,
                    rawDate: _dates[_selectedDateIndex],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(36, 124, 255, 1),
              disabledBackgroundColor:
              const Color.fromRGBO(36, 124, 255, 0.4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text("Continue",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

// ── Step indicator widget — shared across all 3 booking screens ───────────
Widget _buildStepIndicator({required int currentStep}) {
  final steps = ["Date & Time", "Payment", "Summary"];
  return Row(
    children: List.generate(steps.length * 2 - 1, (i) {
      if (i.isOdd) {
        // Connector line
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