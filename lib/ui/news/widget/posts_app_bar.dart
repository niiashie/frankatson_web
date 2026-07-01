import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';

class PostsAppBar extends StatelessWidget {
  final bool isScrolled;
  final bool isWide;
  final VoidCallback onHomeTap;

  const PostsAppBar({
    super.key,
    required this.isScrolled,
    required this.isWide,
    required this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = isScrolled ? AppColors.gradient2 : Colors.white;
    final fgMuted = isScrolled
        ? AppColors.gradient2.withValues(alpha: 0.6)
        : Colors.white70;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isScrolled ? Colors.white : Colors.transparent,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: isScrolled ? 2 : 5,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: isWide ? 50 : 36,
                    height: isWide ? 50 : 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(AppImages.logo,
                          width: isWide ? 50 : 36, height: isWide ? 50 : 36),
                    ),
                  ),
                ),
                if (isWide) ...[
                  const SizedBox(width: 10),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: fgColor,
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize: 25,
                    ),
                    child: const Text("Frankatson"),
                  ),
                ],
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onHomeTap,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: fgMuted,
                      fontFamily: AppFonts.poppinsLight,
                      fontSize: isWide ? 16 : 13,
                    ),
                    child: const Text("Home"),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, size: 16, color: fgMuted),
                const SizedBox(width: 8),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: fgColor,
                    fontFamily: AppFonts.poppinsBold,
                    fontSize: isWide ? 22 : 16,
                  ),
                  child: const Text("Posts"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
