import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/big_screen/widgets/contact_info_card.dart';

class ContactSection extends StatelessWidget {
  final Key? sectionKey;

  const ContactSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Container(
      key: sectionKey,
      width: double.infinity,
      height: isWide ? 750 : 1200,
      color: AppColors.lightCradient1,
      child: Padding(
        padding: isWide ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Contact Us",
              style: TextStyle(
                color: AppColors.gradient2,
                fontSize: 33,
                fontFamily: AppFonts.poppinsBold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 70,
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2],
                ),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We have two major branches in Ghana, one in the Ashanti Region and the other in the capital city.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              "Accra Branch",
              style: TextStyle(fontFamily: AppFonts.poppinsMedium, fontSize: 20),
            ),
            const SizedBox(height: 15),
            const ContactInfoCard(
              addressLine1: "No 28 Orgle Road North",
              addressLine2: "Kaneshie Accra Ghana",
              email: "fboachie@yahoo.com",
              phone1: "0302 224 085",
              phone2: "0302 233 722",
            ),
            const SizedBox(height: 15),
            const Text(
              "Kumasi Branch",
              style: TextStyle(fontFamily: AppFonts.poppinsMedium, fontSize: 20),
            ),
            const SizedBox(height: 15),
            const ContactInfoCard(
              addressLine1: "P.O Box Kw 228, Kwadaso",
              addressLine2: "Off Ohwimasi-Denkyemuoso Road",
              email: "frankatsonksi@yahoo.com",
              phone1: "0322 051 952",
              phone2: "",
            ),
          ],
        ),
      ),
    );
  }
}
