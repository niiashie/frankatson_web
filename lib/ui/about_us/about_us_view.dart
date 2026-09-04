// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/constants/texts.dart';
import 'package:frankoweb/ui/about_us/about_us_view_model.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
import 'package:stacked/stacked.dart';

class AboutUsView extends StackedView<AboutUsViewModel> {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(AboutUsViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, AboutUsViewModel viewModel, Widget? child) {
    final isWide = MediaQuery.of(context).size.width >= 800;
    final isScrolled = viewModel.isScrolled;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: viewModel.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroBanner(isWide),
                _buildOurStory(isWide),
                _buildStatsBar(isWide),
                _buildMissionSection(isWide),
                _buildImpactSection(isWide),
                const SizedBox(height: 60),
              ],
            ),
          ),
          _buildHeader(context, isWide, isScrolled),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isWide, bool isScrolled) {
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
                  onTap: () => Navigator.of(context).pop(),
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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.chevron_right,
                    key: ValueKey(isScrolled),
                    size: 16,
                    color: fgMuted,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: fgColor,
                    fontFamily: AppFonts.poppinsBold,
                    fontSize: isWide ? 22 : 16,
                  ),
                  child: const Text("About Us"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner(bool isWide) {
    return SizedBox(
      width: double.infinity,
      height: isWide ? 480 : 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Reveal(
            effect: RevealEffect.zoomOut,
            scale: 0.94,
            duration: Duration(milliseconds: 1100),
            child: Image(
              image: AssetImage(AppImages.aboutUs),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x55000000), Color(0xCC000000)],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Reveal(
                    effect: RevealEffect.slideDown,
                    distance: 28,
                    child: Text(
                      "About Frankatson Ltd.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.poppinsBold,
                        fontSize: isWide ? 44 : 26,
                        letterSpacing: 0.5,
                        shadows: const [
                          Shadow(
                              color: Colors.black38,
                              blurRadius: 12,
                              offset: Offset(0, 3)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Reveal(
                    effect: RevealEffect.zoomIn,
                    scale: 0.1,
                    delay: Duration(milliseconds: 160),
                    child: SizedBox(
                      width: 60,
                      height: 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColors.gradient1,
                            AppColors.gradient2
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Reveal(
                    delay: const Duration(milliseconds: 280),
                    child: Text(
                      "Your Trusted Partner in Veterinary, Agro-Chemical & Poultry Solutions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: AppFonts.poppinsLight,
                        fontSize: isWide ? 18 : 14,
                      ),
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

  Widget _buildOurStory(bool isWide) {
    final founderCard = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: AppColors.gradient2.withValues(alpha: 0.22),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Image.asset(
              AppImages.francisBoachie,
              width: double.infinity,
              height: 340,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Late Dr. Francis Boachie",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: AppFonts.poppinsMedium,
              fontSize: 15,
              color: AppColors.gradient2),
        ),
        const Text(
          "Founder, Frankatson Ltd.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );

    final storyContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Our Story",
          style: TextStyle(
            color: AppColors.gradient2,
            fontFamily: AppFonts.poppinsBold,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 3,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.gradient1, AppColors.gradient2]),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          AppTexts.aboutUs1,
          style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.75),
        ),
        const SizedBox(height: 16),
        const Text(
          AppTexts.aboutUs2,
          style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.75),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 70 : 50),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Reveal(
                    effect: RevealEffect.slideRight,
                    distance: 60,
                    child: founderCard,
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 6,
                  child: Reveal(
                    effect: RevealEffect.slideLeft,
                    distance: 60,
                    delay: const Duration(milliseconds: 140),
                    child: storyContent,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Reveal(child: founderCard),
                const SizedBox(height: 40),
                Reveal(
                  delay: const Duration(milliseconds: 120),
                  child: storyContent,
                ),
              ],
            ),
    );
  }

  Widget _buildStatsBar(bool isWide) {
    const items = [
      _StatItem(value: "30+", label: "Years of Experience"),
      _StatItem(value: "2", label: "Branches in Ghana"),
      _StatItem(value: "10+", label: "Countries Sourced From"),
      _StatItem(value: "1+", label: "International Award"),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: isWide ? 50 : 36, horizontal: isWide ? 60 : 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFFFC8E4),
            AppColors.gradient2,
            AppColors.gradient1,
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _stagger(items, effect: RevealEffect.zoomIn),
            )
          : Wrap(
              spacing: 20,
              runSpacing: 28,
              alignment: WrapAlignment.center,
              children: _stagger(items, effect: RevealEffect.zoomIn),
            ),
    );
  }

  Widget _buildMissionSection(bool isWide) {
    final cardWidth = isWide ? 290.0 : double.infinity;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 60 : 24, vertical: isWide ? 70 : 50),
      child: Column(
        children: [
          const Reveal(
            effect: RevealEffect.slideDown,
            distance: 24,
            child: Text(
              "Our Mission & Values",
              style: TextStyle(
                color: AppColors.gradient2,
                fontFamily: AppFonts.poppinsBold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Reveal(
            effect: RevealEffect.zoomIn,
            scale: 0.1,
            delay: Duration(milliseconds: 120),
            child: SizedBox(
              width: 60,
              height: 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.gradient1, AppColors.gradient2]),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: _stagger([
              _MissionCard(
                width: cardWidth,
                icon: Icons.flag_outlined,
                title: "Our Mission",
                body: "${AppTexts.aboutUs3} ${AppTexts.aboutUs4}",
              ),
              _MissionCard(
                width: cardWidth,
                icon: Icons.lightbulb_outline,
                title: "Our Philosophy",
                body: AppTexts.aboutUs5,
              ),
              _MissionCard(
                width: cardWidth,
                icon: Icons.storefront_outlined,
                title: "Our Services",
                body: AppTexts.aboutUs7,
              ),
            ], baseDelay: const Duration(milliseconds: 150)),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection(bool isWide) {
    final awardsCard = Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFFFC8E4),
            AppColors.gradient2,
            AppColors.gradient1,
          ],
          stops: [0.0, 0.45, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradient2.withValues(alpha: 0.3),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 64),
          const SizedBox(height: 16),
          const Text(
            "Gold Medal",
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Business Initiative Directors (B.I.D.)",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          const Text(
            "International Organization — United States",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const SizedBox(height: 22),
          Container(width: double.infinity, height: 1, color: Colors.white24),
          const SizedBox(height: 22),
          const Text(
            "Awarded for outstanding contributions to Agricultural Development in Ghana",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.65),
          ),
        ],
      ),
    );

    final textContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Our Impact & Awards",
          style: TextStyle(
            color: AppColors.gradient2,
            fontFamily: AppFonts.poppinsBold,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 3,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.gradient1, AppColors.gradient2]),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
        const SizedBox(height: 24),
        _bulletPoint(AppTexts.aboutUs8),
        const SizedBox(height: 16),
        _bulletPoint(AppTexts.aboutUs9),
        const SizedBox(height: 16),
        _bulletPoint(AppTexts.aboutUs10),
      ],
    );

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 70 : 50),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Reveal(
                    effect: RevealEffect.slideRight,
                    distance: 60,
                    child: textContent,
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 4,
                  child: Reveal(
                    effect: RevealEffect.slideLeft,
                    distance: 60,
                    delay: const Duration(milliseconds: 140),
                    child: awardsCard,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Reveal(child: textContent),
                const SizedBox(height: 40),
                Reveal(
                  delay: const Duration(milliseconds: 120),
                  child: awardsCard,
                ),
              ],
            ),
    );
  }

  /// Wraps each of [children] so they animate in one behind the other.
  List<Widget> _stagger(
    List<Widget> children, {
    RevealEffect effect = RevealEffect.slideUp,
    Duration baseDelay = Duration.zero,
  }) {
    return List.generate(
      children.length,
      (i) => Reveal.staggered(
        index: i,
        effect: effect,
        baseDelay: baseDelay,
        child: children[i],
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.gradient2,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              height: 1.75,
            ),
          ),
        ),
      ],
    );
  }

  @override
  AboutUsViewModel viewModelBuilder(BuildContext context) => AboutUsViewModel();
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String title;
  final String body;

  const _MissionCard({
    required this.width,
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.12),
            blurRadius: 18,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: AppColors.gradient2,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 28)),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.gradient2,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
