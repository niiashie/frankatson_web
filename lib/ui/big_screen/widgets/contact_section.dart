import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/big_screen/widgets/contact_info_card.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';

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
        padding: isWide
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 20),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Reveal(
              effect: RevealEffect.slideDown,
              distance: 24,
              child: Text(
                "Contact Us",
                style: TextStyle(
                  color: AppColors.gradient2,
                  fontSize: 33,
                  fontFamily: AppFonts.poppinsBold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(height: 5),
            Reveal(
              effect: RevealEffect.zoomIn,
              scale: 0.1,
              delay: Duration(milliseconds: 120),
              child: SizedBox(
                width: 70,
                height: 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.gradient1, AppColors.gradient2],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Reveal(
              delay: Duration(milliseconds: 180),
              child: Text(
                "We have two major branches in Ghana, one in the Ashanti Region and the other in the capital city.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Reveal(
              effect: RevealEffect.slideRight,
              delay: Duration(milliseconds: 260),
              child: Text(
                "Accra Branch",
                style:
                    TextStyle(fontFamily: AppFonts.poppinsMedium, fontSize: 20),
              ),
            ),
            SizedBox(height: 15),
            Reveal(
              effect: RevealEffect.slideRight,
              distance: 60,
              delay: Duration(milliseconds: 320),
              child: ContactInfoCard(
                addressLine1: "No 28 Orgle Road North",
                addressLine2: "Kaneshie Accra Ghana",
                email: "fboachie@yahoo.com",
                phone1: "0302 224 085",
                phone2: "0302 233 722",
              ),
            ),
            SizedBox(height: 15),
            Reveal(
              effect: RevealEffect.slideLeft,
              delay: Duration(milliseconds: 400),
              child: Text(
                "Kumasi Branch",
                style:
                    TextStyle(fontFamily: AppFonts.poppinsMedium, fontSize: 20),
              ),
            ),
            SizedBox(height: 15),
            Reveal(
              effect: RevealEffect.slideLeft,
              distance: 60,
              delay: Duration(milliseconds: 460),
              child: ContactInfoCard(
                addressLine1: "P.O Box Kw 228, Kwadaso",
                addressLine2: "Off Ohwimasi-Denkyemuoso Road",
                email: "frankatsonksi@yahoo.com",
                phone1: "0322 051 952",
                phone2: "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
