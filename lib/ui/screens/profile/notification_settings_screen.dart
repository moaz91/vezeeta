import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _docNow = true;
  bool _sound = true;
  bool _vibrate = true;
  bool _appUpdates = false;
  bool _specialOffers = true;

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
        title: const Text("Notification",
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
            _toggleItem("Notification from DocNow", _docNow,
                (v) => setState(() => _docNow = v)),
            _toggleItem("Sound", _sound,
                (v) => setState(() => _sound = v)),
            _toggleItem("Vibrate", _vibrate,
                (v) => setState(() => _vibrate = v)),
            _toggleItem("App Updates", _appUpdates,
                (v) => setState(() => _appUpdates = v)),
            _toggleItem("Special Offers", _specialOffers,
                (v) => setState(() => _specialOffers = v)),
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
