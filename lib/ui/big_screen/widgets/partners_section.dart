import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/big_screen/widgets/partner_item.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';

class PartnersSection extends StatelessWidget {
  final Key? sectionKey;
  final List<String> partnerImages;
  final List<String> partnerNames;
  final VoidCallback? onViewMore;

  const PartnersSection({
    super.key,
    this.sectionKey,
    required this.partnerImages,
    required this.partnerNames,
    this.onViewMore,
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
            const Reveal(
              effect: RevealEffect.slideDown,
              distance: 24,
              child: Text(
                "Our Partners",
                style: TextStyle(
                  color: AppColors.gradient2,
                  fontSize: 33,
                  fontFamily: AppFonts.poppinsBold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Reveal(
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
            const SizedBox(height: 20),
            SizedBox(
              height: 230,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      partnerNames.length,
                      (index) => Reveal.staggered(
                        index: index,
                        effect: RevealEffect.slideLeft,
                        distance: 50,
                        baseDelay: const Duration(milliseconds: 150),
                        step: const Duration(milliseconds: 80),
                        child: PartnerItem(
                          image: partnerImages[index],
                          name: partnerNames[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (onViewMore != null) ...[
              const SizedBox(height: 15),
              Reveal(
                delay: const Duration(milliseconds: 400),
                child: Material(
                  color: AppColors.gradient2,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  elevation: 2,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    onTap: onViewMore,
                    child: Container(
                      width: 150,
                      height: 46,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "View More",
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsMedium,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.chevron_right,
                                size: 15, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
