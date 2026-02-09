import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            const Text(
              "Fill Your Profile",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Color.fromRGBO(36, 124, 255, 1),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Please take a few minutes to fill out your profile with as much detail as possible.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            ),

            const SizedBox(height: 50),

            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(194, 194, 194, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(36, 124, 255, 1),
                  ),
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(194, 194, 194, 1),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Full Name",
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(194, 194, 194, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(36, 124, 255, 1),
                  ),
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(194, 194, 194, 1),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                  });
                }
              },
              decoration: InputDecoration(
                hintText: "Birthday",
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                filled: true,
                fillColor: const Color.fromRGBO(253, 253, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(194, 194, 194, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(36, 124, 255, 1),
                  ),
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(194, 194, 194, 1),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Phone number with country picker
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(253, 253, 255, 1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromRGBO(194, 194, 194, 1),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 135,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        iconTheme: const IconThemeData(size: 16),
                      ),
                      child: CountryCodePicker(
                        margin: EdgeInsets.zero,
                        flagWidth: 30,
                        padding: EdgeInsets.only(left: 0, right: 0),
                        initialSelection: 'EG',
                        favorite: const ['+20', 'EG', '+966', 'SA'],
                        showFlag: true,
                        showDropDownButton: true,
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      color: Color.fromRGBO(194, 194, 194, 1),
                    ),
                  ),
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Your number",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(194, 194, 194, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            Container(
              width: screenWidth,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(36, 124, 255, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}

Widget _socialIcon(String asset) {
  return Container(
    width: 46,
    height: 46,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(245, 245, 245, 1),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Image.asset(asset),
  );
}
