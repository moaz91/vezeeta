import 'package:flutter/material.dart';
import 'package:vezeeta/features/home/data/doctor_model.dart';
import 'package:vezeeta/features/appointment/ui/book_summary_screen.dart';

class BookPaymentScreen extends StatefulWidget {
  final Doctor doctor;
  final String selectedDate;
  final String selectedTime;
  final String appointmentType;
  final DateTime rawDate;

  const BookPaymentScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.appointmentType,
    required this.rawDate,
  });

  @override
  State<BookPaymentScreen> createState() => _BookPaymentScreenState();
}

class _BookPaymentScreenState extends State<BookPaymentScreen> {
  // 0 = Credit Card, 1 = Bank Transfer, 2 = Paypal
  int _selectedPaymentCategory = 0;

  // Credit card option index
  int _selectedCard = 2; // Defaults to Capital One

  final List<Map<String, dynamic>> _cards = [
    {'name': 'Master Card',     'color': const Color(0xFFEB5757), 'icon': Icons.credit_card},
    {'name': 'American Express','color': const Color(0xFF2979FF), 'icon': Icons.credit_card},
    {'name': 'Capital One',     'color': const Color(0xFF6C63FF), 'icon': Icons.credit_card},
    {'name': 'Barclays',        'color': const Color(0xFF00B0FF), 'icon': Icons.credit_card},
  ];

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
            _buildStepIndicator(currentStep: 2),
            const SizedBox(height: 28),

            const Text("Payment Option",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(height: 20),

            // ── Credit Card section ───────────────────────────────────────
            _paymentCategoryTile(
              index: 0,
              label: "Credit Card",
              leading: Radio<int>(
                value: 0,
                groupValue: _selectedPaymentCategory,
                onChanged: (v) =>
                    setState(() => _selectedPaymentCategory = v!),
                activeColor: const Color.fromRGBO(36, 124, 255, 1),
              ),
            ),

            // Show card list only when Credit Card is selected
            if (_selectedPaymentCategory == 0) ...[
              const SizedBox(height: 8),
              ..._cards.asMap().entries.map((entry) {
                final i = entry.key;
                final card = entry.value;
                final isSelected = _selectedCard == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCard = i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8, left: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: isSelected
                              ? const Color.fromRGBO(36, 124, 255, 1)
                              : const Color.fromRGBO(230, 230, 230, 1)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: (card['color'] as Color)
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(card['icon'] as IconData,
                              color: card['color'] as Color, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(card['name'] as String,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle,
                              color: Color.fromRGBO(36, 124, 255, 1),
                              size: 20),
                      ],
                    ),
                  ),
                );
              }),
            ],

            const Divider(color: Color(0xFFEEEEEE)),

            // ── Bank Transfer ─────────────────────────────────────────────
            _paymentCategoryTile(
              index: 1,
              label: "Bank Transfer",
              leading: Radio<int>(
                value: 1,
                groupValue: _selectedPaymentCategory,
                onChanged: (v) =>
                    setState(() => _selectedPaymentCategory = v!),
                activeColor: const Color.fromRGBO(36, 124, 255, 1),
              ),
            ),

            const Divider(color: Color(0xFFEEEEEE)),

            // ── Paypal ────────────────────────────────────────────────────
            _paymentCategoryTile(
              index: 2,
              label: "Paypal",
              leading: Radio<int>(
                value: 2,
                groupValue: _selectedPaymentCategory,
                onChanged: (v) =>
                    setState(() => _selectedPaymentCategory = v!),
                activeColor: const Color.fromRGBO(36, 124, 255, 1),
              ),
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
            onPressed: () {
              final paymentCategories = ["Credit Card", "Bank Transfer", "Paypal"];
              final paymentLabel = _selectedPaymentCategory == 0
                  ? _cards[_selectedCard]['name'] as String
                  : paymentCategories[_selectedPaymentCategory];

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookSummaryScreen(
                    doctor: widget.doctor,
                    selectedDate: widget.selectedDate,
                    selectedTime: widget.selectedTime,
                    appointmentType: widget.appointmentType,
                    paymentMethod: paymentLabel,
                    rawDate: widget.rawDate,
                  ),
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
            child: const Text("Continue",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _paymentCategoryTile({
    required int index,
    required String label,
    required Widget leading,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentCategory = index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ],
        ),
      ),
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