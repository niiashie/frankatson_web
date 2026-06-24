import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';

class ContactInfoCard extends StatelessWidget {
  final String addressLine1;
  final String addressLine2;
  final String email;
  final String phone1;
  final String phone2;

  const ContactInfoCard({
    super.key,
    required this.addressLine1,
    required this.addressLine2,
    required this.email,
    required this.phone1,
    required this.phone2,
  });

  Widget _infoItem(IconData icon, String label, String line1, String line2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: AppColors.gradient2,
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(icon, size: 27, color: Colors.white)),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontFamily: AppFonts.poppinsMedium)),
        const SizedBox(height: 10),
        Text(line1),
        if (line2.isNotEmpty) Text(line2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    final items = [
      _infoItem(Icons.location_on_outlined, "Address:", addressLine1, addressLine2),
      _infoItem(Icons.email_outlined, "Email:", email, ""),
      _infoItem(Icons.phone_outlined, "Phone:", phone1, phone2),
    ];

    final cardDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.grey[400]!, blurRadius: 3.0, spreadRadius: 1),
      ],
    );

    if (isWide) {
      return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 200,
        decoration: cardDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: items.map((e) => Expanded(child: e)).toList(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: cardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          ...items.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: e,
              )),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
