import 'package:flutter/material.dart';
import 'rescheduled_details_screen.dart';

class RescheduleScreen extends StatefulWidget {
  const RescheduleScreen({super.key});

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  int _selectedDateIndex = 2;
  String? _selectedTime;
  int _selectedType = 0;

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
        title: const Text("Reschedule",
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
            const SizedBox(height: 24),

            // ── Select Date ───────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Select Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                const Text("Set Manual",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(36, 124, 255, 1))),
              ],
            ),
            const SizedBox(height: 16),

            // ── Horizontal date picker ────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.chevron_left,
                    color: Color.fromRGBO(180, 180, 180, 1)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        _dates.length > 5 ? 5 : _dates.length, (i) {
                      final date = _dates[i];
                      final isSelected = _selectedDateIndex == i;
                      const dayNames = [
                        'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
                      ];
                      final dayName = dayNames[date.weekday - 1];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedDateIndex = i),
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
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  : const Color.fromRGBO(
                                      100, 100, 100, 1))),
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
                          color:
                              const Color.fromRGBO(232, 243, 255, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(type['icon'] as IconData,
                            color:
                                const Color.fromRGBO(36, 124, 255, 1),
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
                        builder: (_) => RescheduledDetailsScreen(
                          selectedDate: _selectedDateStr,
                          selectedTime: _selectedTime!,
                          appointmentType: _appointmentTypes[
                              _selectedType]['label'] as String,
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
            child: const Text("Reschedule",
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
