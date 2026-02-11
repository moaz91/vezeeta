import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'sign_in.dart';

class FillMyProfile extends StatefulWidget {
  const FillMyProfile({super.key});

  @override
  State<FillMyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<FillMyProfile> {
  final _dateController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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

            SizedBox(height: 50),

            /// Profile Avatar - Exactly as provided
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Main Circle Avatar
                  Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE0E0E0), // light grey background
                    ),
                    child: ClipOval(
                      child: _image != null
                          ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                        width: 160,
                        height: 160,
                      )
                          : const Icon(
                        Icons.person,
                        size: 80,
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                  ),

                  // Edit Button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

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
                        padding: const EdgeInsets.only(left: 0, right: 0),
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

            const Spacer(),

            GestureDetector(
              onTap: () {
                // Handle submit
              },
              child: Container(
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
            ),
            const SizedBox(height: 20),
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