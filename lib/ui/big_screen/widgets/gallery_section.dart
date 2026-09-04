import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
import 'package:frankoweb/ui/shared/gallery_slider.dart';

class GallerySection extends StatelessWidget {
  final List<String> images;

  const GallerySection({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (images.isNotEmpty) ...[
          const Reveal(
            effect: RevealEffect.slideDown,
            distance: 24,
            child: Text(
              "Our Gallery",
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
        ],
        GallerySlider(images: images),
      ],
    );
  }
}
