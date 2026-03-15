import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
        title: const Text("Payment",
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
              child: const Icon(Icons.wallet_outlined,
                  color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 8),
          _paymentItem(
            logo: _paypalLogo(),
            name: "Paypal",
            last: "37842",
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _paymentItem(
            logo: _mastercardLogo(),
            name: "Master Card",
            last: "42482",
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _paymentItem(
            logo: _applePayLogo(),
            name: "Apple Pay",
            last: "37476",
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _paymentItem(
            logo: _payoneerLogo(),
            name: "Payoneer",
            last: "57643",
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _paymentItem(
            logo: _danaLogo(),
            name: "Dana",
            last: "10094",
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(36, 124, 255, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: const Text("Add New",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _paymentItem({
    required Widget logo,
    required String name,
    required String last,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          SizedBox(width: 72, child: logo),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 4),
                Text("**** **** **** $last",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(150, 150, 150, 1))),
              ],
            ),
          ),
          const Text("Connected",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(36, 124, 255, 1))),
        ],
      ),
    );
  }

  // ── Brand logo widgets ────────────────────────────────────────────────────

  Widget _paypalLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Paypal P logo using styled text
        Stack(
          children: [
            Text("P",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF003087),
                    height: 1)),
            Positioned(
              left: 3,
              top: 0,
              child: Text("P",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF009CDE),
                      height: 1)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mastercardLogo() {
    return SizedBox(
      width: 52,
      height: 32,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEB001B),
              ),
            ),
          ),
          Positioned(
            left: 16,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF79E1B).withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _applePayLogo() {
    return const Text(
      "Pay",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: -0.5),
    );
  }

  Widget _payoneerLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4800),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text("pay",
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5)),
    );
  }

  Widget _danaLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF118EEA),
          ),
          child: const Center(
            child: Text("D",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(width: 4),
        const Text("DANA",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF118EEA))),
      ],
    );
  }
}
