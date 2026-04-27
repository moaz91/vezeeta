import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vezeeta/features/profile/logic/profile_bloc.dart';
import 'package:vezeeta/features/profile/logic/profile_events.dart';
import 'package:vezeeta/features/profile/logic/profile_states.dart';
import 'package:vezeeta/features/profile/data/user_model.dart';

class PersonalInformationScreen extends StatefulWidget {
  final UserModel? user;

  const PersonalInformationScreen({super.key, required this.user});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedGender = '0';
  bool _populated = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _populate(UserModel user) {
    if (_populated) return;
    _populated = true;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _selectedGender = user.gender;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(Dio())..add(FetchProfile()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            setState(() => _populate(state.user));
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully")),
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isFetching = state is ProfileLoading && !_populated;
          final isSaving = state is ProfileLoading && _populated;

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
              title: const Text("Personal information",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black)),
              centerTitle: true,
            ),
            body: isFetching
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // ── Avatar ────────────────────────────────────────
                  Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(232, 243, 255, 1),
                          border: Border.all(
                              color: const Color.fromRGBO(220, 220, 220, 1),
                              width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset("assets/rec.png",
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromRGBO(
                                    220, 220, 220, 1)),
                          ),
                          child: const Icon(Icons.edit,
                              size: 14,
                              color: Color.fromRGBO(36, 124, 255, 1)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── Name ──────────────────────────────────────────
                  _field(
                    controller: _nameController,
                    hint: "Full Name",
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),

                  // ── Email ─────────────────────────────────────────
                  _field(
                    controller: _emailController,
                    hint: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // ── Password ──────────────────────────────────────
                  _field(
                    controller: _passwordController,
                    hint: "New Password (leave blank to keep current)",
                    obscure: true,
                  ),
                  const SizedBox(height: 16),

                  // ── Phone with CountryCodePicker ──────────────────
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(248, 250, 255, 1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: const Color.fromRGBO(220, 220, 220, 1)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 135,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              iconTheme:
                              const IconThemeData(size: 16),
                            ),
                            child: CountryCodePicker(
                              margin: EdgeInsets.zero,
                              flagWidth: 30,
                              padding: EdgeInsets.zero,
                              initialSelection: 'EG',
                              favorite: const [
                                '+20', 'EG', '+966', 'SA'
                              ],
                              showFlag: true,
                              showDropDownButton: true,
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                          child: VerticalDivider(
                            color: Color.fromRGBO(220, 220, 220, 1),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: "Your number",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(180, 180, 180, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Info note ─────────────────────────────────────
                  const Text(
                    "When you set up your personal information settings, you should take care to provide accurate information.",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(150, 150, 150, 1),
                        height: 1.5),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isFetching || isSaving
                      ? null
                      : () {
                    context.read<ProfileBloc>().add(
                      UpdateProfile(
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        gender: _selectedGender,
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
                  child: isSaving
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                      : const Text("Save",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color.fromRGBO(248, 250, 255, 1),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
          const BorderSide(color: Color.fromRGBO(220, 220, 220, 1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
          const BorderSide(color: Color.fromRGBO(220, 220, 220, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
          const BorderSide(color: Color.fromRGBO(36, 124, 255, 1)),
        ),
        hintStyle: const TextStyle(
            fontSize: 14, color: Color.fromRGBO(180, 180, 180, 1)),
      ),
    );
  }
}