import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/constants/routes.dart';
import 'package:frankoweb/constants/texts.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';

class AboutSection extends StatelessWidget {
  final Key? sectionKey;

  const AboutSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 800;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      child: Column(
        key: sectionKey,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Reveal(
            effect: RevealEffect.slideDown,
            distance: 24,
            child: Text(
              "About Us",
              style: TextStyle(
                color: AppColors.gradient2,
                fontSize: 30,
                fontFamily: AppFonts.poppinsBold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Reveal(
            effect: RevealEffect.zoomIn,
            scale: 0.1,
            delay: Duration(milliseconds: 120),
            child: SizedBox(
              width: 50,
              height: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.gradient1,
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: isWide ? w / 1.3 : double.infinity,
            margin: isWide
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Reveal(
                  effect:
                      isWide ? RevealEffect.slideRight : RevealEffect.slideUp,
                  distance: 60,
                  delay: const Duration(milliseconds: 150),
                  child: SizedBox(
                    width: isWide ? w / 2.7 : double.infinity,
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: isWide
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          const Text(
                            AppTexts.aboutUs1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xff555555),
                              fontSize: 15,
                              fontFamily: AppFonts.poppinsLight,
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            AppTexts.aboutUs2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xff555555),
                              fontSize: 15,
                              fontFamily: AppFonts.poppinsLight,
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Material(
                            color: AppColors.gradient2,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            elevation: 2,
                            child: InkWell(
                              child: Container(
                                width: 170,
                                height: 50,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                child: const Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Read More",
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
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.aboutUsScreen);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Reveal(
                  effect:
                      isWide ? RevealEffect.slideLeft : RevealEffect.slideUp,
                  distance: 60,
                  delay: const Duration(milliseconds: 280),
                  child: Container(
                    width: isWide ? w / 2.7 : double.infinity,
                    height: 400,
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 20,
                      bottom: 20,
                      right: isWide ? 0 : 20,
                    ),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      elevation: 2,
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child:
                            Image.asset(AppImages.director, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
