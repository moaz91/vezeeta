import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _rememberPassword = true;
  bool _faceId = false;
  bool _pin = true;

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
        title: const Text("Security",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            _toggleItem("Remember password", _rememberPassword,
                (v) => setState(() => _rememberPassword = v)),
            _toggleItem("Face ID", _faceId,
                (v) => setState(() => _faceId = v)),
            _toggleItem("PIN", _pin,
                (v) => setState(() => _pin = v)),
            // Google Authenticator — chevron only, no toggle
            Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Google Authenticator",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        Icon(Icons.chevron_right,
                            color: Color.fromRGBO(180, 180, 180, 1)),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFF2F2F2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleItem(
      String label, bool value, ValueChanged<bool> onChanged) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.white,
                activeTrackColor: const Color.fromRGBO(36, 124, 255, 1),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF2F2F2)),
      ],
    );
  }
}
