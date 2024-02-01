import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';

class TeamMember extends StatelessWidget {
  final String name;
  final String role;
  const TeamMember({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gradient1),
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontFamily: AppFonts.poppinsMedium, fontSize: 16),
            ),
            Text(
              role,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ));
  }
}
