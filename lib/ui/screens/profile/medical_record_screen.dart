import 'package:flutter/material.dart';

// Static model — no API endpoint for medical records in the collection
class MedicalRecordItem {
  final String date;    // e.g. "Feb 25"
  final String title;
  final List<String> details;

  MedicalRecordItem({
    required this.date,
    required this.title,
    required this.details,
  });
}

class MedicalRecordGroup {
  final String month;   // e.g. "This Month", "January"
  final List<MedicalRecordItem> items;

  MedicalRecordGroup({required this.month, required this.items});
}

final List<MedicalRecordGroup> _records = [
  MedicalRecordGroup(
    month: "This Month",
    items: [
      MedicalRecordItem(
        date: "Feb 25",
        title: "End of observation",
        details: [],
      ),
      MedicalRecordItem(
        date: "Feb 25",
        title: "Blood Analysis",
        details: [
          "red blood cell : 4.10 million cells/mcL",
          "hemogoblin : 142 grams/L",
          "hematocrit : 33.6%",
          "white blood cells : 3.850 cells/mcL",
        ],
      ),
      MedicalRecordItem(
        date: "Feb 25",
        title: "Blood Analysis",
        details: [
          "red blood cell : 3.90 million cells/mcL",
          "hemogoblin : 122 grams/L",
          "hematocrit : 47.7%",
          "white blood cells : 4.300 cells/mcL",
        ],
      ),
    ],
  ),
  MedicalRecordGroup(
    month: "January",
    items: [
      MedicalRecordItem(
        date: "Feb 25",
        title: "End of observation",
        details: [],
      ),
      MedicalRecordItem(
        date: "Feb 25",
        title: "Blood Analysis",
        details: [
          "red blood cell : 4.30 million cells/mcL",
          "hemogoblin : 132 grams/L",
          "hematocrit : 37.7%",
          "white blood cells : 4.700 cells/mcL",
        ],
      ),
      MedicalRecordItem(
        date: "Feb 25",
        title: "Blood Analysis",
        details: [
          "red blood cell : 3.90 million cells/mcL",
          "hemogoblin : 118 grams/L",
          "hematocrit : 38.7%",
          "white blood cells : 4.500 cells/mcL",
        ],
      ),
    ],
  ),
];

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({super.key});

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
              border: Border.all(
                  color: const Color.fromRGBO(237, 237, 237, 1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chevron_left, color: Colors.black),
          ),
        ),
        title: const Text("Medical Record",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(237, 237, 237, 1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.more_horiz,
                  color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _records.length,
        itemBuilder: (context, groupIndex) {
          final group = _records[groupIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // ── Month header ────────────────────────────────────────
              Text(group.month,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              const SizedBox(height: 12),

              // ── Records in this group ───────────────────────────────
              ...group.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date column
                        SizedBox(
                          width: 52,
                          child: Text(item.date,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color:
                                      Color.fromRGBO(117, 117, 117, 1))),
                        ),
                        const SizedBox(width: 12),

                        // Content column
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(item.title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              if (item.details.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                ...item.details.map((d) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2),
                                      child: Text(d,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(
                                                  117, 117, 117, 1),
                                              height: 1.5)),
                                    )),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
