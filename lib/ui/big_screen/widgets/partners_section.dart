import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/big_screen/widgets/partner_item.dart';

class PartnersSection extends StatelessWidget {
  final Key? sectionKey;
  final List<String> partnerImages;
  final List<String> partnerNames;

  const PartnersSection({
    super.key,
    this.sectionKey,
    required this.partnerImages,
    required this.partnerNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      height: 400,
      color: AppColors.lightCradient1,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Our Partners",
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
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 40),
              height: 230,
              child: ListView.builder(
                itemCount: partnerNames.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => PartnerItem(
                  image: partnerImages[index],
                  name: partnerNames[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
