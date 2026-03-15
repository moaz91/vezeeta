import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'q': "What should I expect during a doctor's appointment?",
      'a': "During a doctor's appointment, you can expect to discuss your medical history, current symptoms or concerns, and any medications or treatments you are taking. The doctor will likely perform a physical exam and may order additional tests or procedures if necessary.",
    },
    {
      'q': "What should I bring to my doctor's appointment?",
      'a': "Bring your insurance card, a list of current medications, any relevant medical records, and a list of questions you want to ask.",
    },
    {
      'q': "What if I need to cancel or reschedule my appointment?",
      'a': "You can cancel or reschedule through the app at least 24 hours in advance to avoid any cancellation fees.",
    },
    {
      'q': "How do I make an appointment with a doctor?",
      'a': "Simply browse doctors, select one, choose a date and time, and confirm your booking through the app.",
    },
    {
      'q': "How early should I arrive for my doctor's appointment?",
      'a': "We recommend arriving 10–15 minutes early to complete any necessary paperwork.",
    },
    {
      'q': "How long will my doctor's appointment take?",
      'a': "Most appointments last between 15–30 minutes, but this can vary depending on the reason for your visit.",
    },
    {
      'q': "How much will my doctor's appointment cost?",
      'a': "The cost depends on the doctor and appointment type. You can see the price before booking in the app.",
    },
    {
      'q': "What should I look for in a good doctor?",
      'a': "Look for qualifications, experience, patient reviews, good communication skills, and availability.",
    },
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
          child: const Icon(Icons.chevron_left,
              color: Colors.black, size: 28),
        ),
        title: const Text("FAQ",
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: _faqs.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Color(0xFFF2F2F2)),
        itemBuilder: (context, index) {
          final faq = _faqs[index];
          final isExpanded = _expandedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(faq['q']!,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color.fromRGBO(150, 150, 150, 1),
                        size: 20,
                      ),
                    ],
                  ),
                  if (isExpanded) ...[
                    const SizedBox(height: 10),
                    Text(faq['a']!,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(97, 97, 97, 1),
                            height: 1.6)),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
