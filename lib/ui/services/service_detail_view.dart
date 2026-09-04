import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
import 'package:frankoweb/constants/images.dart';

class ServiceDetailView extends StatefulWidget {
  final String title;
  final String headline;
  final List<String> introParagraphs;
  final String bulletSectionTitle;
  final List<String> bullets;
  final String conclusionText;
  final IconData? iconData;
  final String? iconImage;
  final String? featurePhoto;

  const ServiceDetailView({
    Key? key,
    required this.title,
    required this.headline,
    required this.introParagraphs,
    required this.bulletSectionTitle,
    required this.bullets,
    required this.conclusionText,
    this.iconData,
    this.iconImage,
    this.featurePhoto,
  }) : super(key: key);

  @override
  State<ServiceDetailView> createState() => _ServiceDetailViewState();
}

class _ServiceDetailViewState extends State<ServiceDetailView> {
  final _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 60;
      if (scrolled != _isScrolled) {
        setState(() => _isScrolled = scrolled);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(isWide),
                _buildIntroSection(isWide),
                _buildBulletsSection(isWide),
                _buildConclusion(isWide),
                const SizedBox(height: 60),
              ],
            ),
          ),
          _buildHeader(context, isWide),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isWide) {
    final fgColor = _isScrolled ? AppColors.gradient2 : Colors.white;
    final fgMuted = _isScrolled
        ? AppColors.gradient2.withValues(alpha: 0.6)
        : Colors.white70;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: _isScrolled ? Colors.white : Colors.transparent,
        boxShadow: _isScrolled
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
              children: [
                Material(
                  elevation: _isScrolled ? 2 : 5,
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
                    child: const Text("Services"),
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
                    fontSize: isWide ? 20 : 14,
                  ),
                  child: Text(widget.title),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(bool isWide) {
    Widget iconWidget(double size, Color color) {
      if (widget.iconData != null) {
        return Icon(widget.iconData, color: color, size: size);
      }
      if (widget.iconImage != null) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          child: Image.asset(widget.iconImage!, width: size, height: size),
        );
      }
      return const SizedBox();
    }

    return SizedBox(
      width: double.infinity,
      height: isWide ? 480 : 340,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFFFC8E4),
                  AppColors.gradient2,
                  AppColors.gradient1,
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
          Positioned(
            right: isWide ? -20 : -40,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: iconWidget(isWide ? 340 : 230, Colors.white),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 100 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Reveal(
                    effect: RevealEffect.zoomIn,
                    scale: 0.5,
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2),
                      ),
                      child: Center(child: iconWidget(38, Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Reveal(
                    effect: RevealEffect.slideDown,
                    distance: 26,
                    delay: const Duration(milliseconds: 120),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.poppinsBold,
                        fontSize: isWide ? 40 : 24,
                        letterSpacing: 0.4,
                        shadows: const [
                          Shadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 3)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Reveal(
                    effect: RevealEffect.zoomIn,
                    scale: 0.1,
                    delay: const Duration(milliseconds: 240),
                    child: Container(
                      width: 60,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Reveal(
                    delay: const Duration(milliseconds: 340),
                    child: Text(
                      widget.headline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontFamily: AppFonts.poppinsLight,
                        fontSize: isWide ? 17 : 13,
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

  Widget _buildIntroSection(bool isWide) {
    final textBlock = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < widget.introParagraphs.length; i++) ...[
          if (i > 0) const SizedBox(height: 18),
          Text(
            widget.introParagraphs[i],
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ],
      ],
    );

    final photoCard = widget.featurePhoto != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gradient2.withValues(alpha: 0.18),
                  blurRadius: 24,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.asset(
                widget.featurePhoto!,
                width: double.infinity,
                height: 360,
                fit: BoxFit.cover,
              ),
            ),
          )
        : null;

    final hPad = isWide ? 80.0 : 24.0;
    final vPad = isWide ? 65.0 : 44.0;

    if (photoCard == null || !isWide) {
      return Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Reveal(child: textBlock),
            if (photoCard != null) ...[
              const SizedBox(height: 32),
              Reveal(
                effect: RevealEffect.zoomIn,
                delay: const Duration(milliseconds: 140),
                child: photoCard,
              ),
            ],
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Reveal(
              effect: RevealEffect.slideRight,
              distance: 60,
              child: textBlock,
            ),
          ),
          const SizedBox(width: 56),
          Expanded(
            flex: 5,
            child: Reveal(
              effect: RevealEffect.slideLeft,
              distance: 60,
              delay: const Duration(milliseconds: 140),
              child: photoCard,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletsSection(bool isWide) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 60 : 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            effect: RevealEffect.slideRight,
            child: Text(
              widget.bulletSectionTitle,
              style: const TextStyle(
                color: AppColors.gradient2,
                fontFamily: AppFonts.poppinsBold,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Reveal(
            effect: RevealEffect.zoomIn,
            scale: 0.1,
            delay: const Duration(milliseconds: 120),
            child: Container(
              width: 50,
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.gradient1, AppColors.gradient2]),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: widget.bullets.indexed
                .map((e) => Reveal.staggered(
                      index: e.$1,
                      step: const Duration(milliseconds: 70),
                      baseDelay: const Duration(milliseconds: 160),
                      child: _BulletCard(text: e.$2, isWide: isWide),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConclusion(bool isWide) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 50 : 36),
      child: Reveal(
        effect: RevealEffect.slideRight,
        distance: 50,
        child: Row(
          children: [
            Container(
              width: 4,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.gradient1, AppColors.gradient2],
                ),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.conclusionText,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  height: 1.8,
                  fontFamily: AppFonts.poppinsLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletCard extends StatelessWidget {
  final String text;
  final bool isWide;

  const _BulletCard({required this.text, required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isWide ? 340.0 : double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2]),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check, color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black87, fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
