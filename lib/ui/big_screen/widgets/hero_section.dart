import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';

class HeroSection extends StatelessWidget {
  static const List<String> _headline = [
    "Sort Out All",
    "Your Veterinary And",
    "Farming Issues With",
    "The Farmer's Friend",
  ];

  final Key? sectionKey;
  final VoidCallback onServicesClicked;
  final VoidCallback onContactClicked;

  const HeroSection({
    super.key,
    this.sectionKey,
    required this.onServicesClicked,
    required this.onContactClicked,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 800;
    final headingStyle = TextStyle(
      color: Colors.white,
      fontSize: isWide ? w / 28 : 32,
      fontFamily: AppFonts.poppinsBold,
      height: 1.25,
      letterSpacing: 0.5,
      shadows: const [
        Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3)),
      ],
    );

    return Container(
      key: sectionKey,
      width: double.infinity,
      height: isWide ? 580 : 500,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFFFC8E4), // light pastel pink — bright end
            AppColors.gradient2, // vibrant mid-pink
            AppColors.gradient1, // deep/muted end
          ],
          stops: [0.0, 0.45, 1.0],
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Stack(
        children: [
          if (isWide)
            Align(
              alignment: Alignment.centerRight,
              child: Reveal(
                effect: RevealEffect.slideLeft,
                distance: 70,
                duration: const Duration(milliseconds: 900),
                delay: const Duration(milliseconds: 150),
                child: Image.asset(
                  AppImages.animals,
                  width: w / 2,
                  height: 520,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Align(
            alignment: isWide ? Alignment.centerLeft : Alignment.center,
            child: Padding(
              padding: isWide
                  ? const EdgeInsets.only(left: 60, top: 60)
                  : const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isWide
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  ...List.generate(
                    _headline.length,
                    (i) => Reveal.staggered(
                      index: i,
                      effect: RevealEffect.slideRight,
                      distance: 45,
                      step: const Duration(milliseconds: 120),
                      child: Text(_headline[i], style: headingStyle),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Reveal(
                    delay: const Duration(milliseconds: 620),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HoverLift(
                          child: Material(
                            color: Colors.white,
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
                                  child: Text(
                                    "View Services",
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppinsMedium,
                                      color: AppColors.gradient2,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: onServicesClicked,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        HoverLift(
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            child: Container(
                              width: 170,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: const Center(
                                child: Text(
                                  "Contact Us",
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsMedium,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            onTap: onContactClicked,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
