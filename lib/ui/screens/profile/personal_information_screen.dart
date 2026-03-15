import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_bloc.dart';
import '../../../logic/profile/profile_events.dart';
import '../../../logic/profile/profile_states.dart';
import '../../../models/user_model.dart';

class PersonalInformationScreen extends StatefulWidget {
  final UserModel? user;

  const PersonalInformationScreen({super.key, required this.user});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String _selectedGender = '0';

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.user?.name ?? '');
    _emailController =
        TextEditingController(text: widget.user?.email ?? '');
    _phoneController =
        TextEditingController(text: widget.user?.phone ?? '');
    _selectedGender = widget.user?.gender ?? '0';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(Dio()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
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
          final isLoading = state is ProfileLoading;

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
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // ── Avatar ──────────────────────────────────────────────
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

                  // ── Name ────────────────────────────────────────────────
                  _field(
                    controller: _nameController,
                    hint: "Full Name",
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),

                  // ── Email ───────────────────────────────────────────────
                  _field(
                    controller: _emailController,
                    hint: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // ── Password placeholder ────────────────────────────────
                  _field(
                    controller: TextEditingController(text: "Password"),
                    hint: "Password",
                    obscure: true,
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),

                  // ── Phone ───────────────────────────────────────────────
                  _field(
                    controller: _phoneController,
                    hint: "Phone",
                    keyboardType: TextInputType.phone,
                    prefix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("🇬🇧",
                            style: TextStyle(fontSize: 18)),
                        SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down,
                            size: 18,
                            color: Color.fromRGBO(150, 150, 150, 1)),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Info note ───────────────────────────────────────────
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
                  onPressed: isLoading
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
                      : const Text("Save",
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

  Widget _field({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool obscure = false,
    bool readOnly = false,
    Widget? prefix,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefix != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: prefix)
            : null,
        prefixIconConstraints:
            prefix != null ? const BoxConstraints() : null,
        filled: true,
        fillColor: const Color.fromRGBO(248, 250, 255, 1),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
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
          borderSide: const BorderSide(
              color: Color.fromRGBO(36, 124, 255, 1)),
        ),
        hintStyle: const TextStyle(
            fontSize: 14, color: Color.fromRGBO(180, 180, 180, 1)),
      ),
    );
  }
}
