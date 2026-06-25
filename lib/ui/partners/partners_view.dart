import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/partners/partners_view_model.dart';
import 'package:stacked/stacked.dart';

class PartnersScreenView extends StackedView<PartnersViewModel> {
  const PartnersScreenView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(PartnersViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, PartnersViewModel viewModel, Widget? child) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: viewModel.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(isWide),
                _buildIntro(isWide),
                _buildPartnersGrid(isWide, viewModel),
                const SizedBox(height: 60),
              ],
            ),
          ),
          _buildHeader(context, isWide, viewModel.isScrolled),
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
                Icon(Icons.chevron_right, size: 16, color: fgMuted),
                const SizedBox(width: 8),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: fgColor,
                    fontFamily: AppFonts.poppinsBold,
                    fontSize: isWide ? 22 : 16,
                  ),
                  child: const Text("Our Partners"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(bool isWide) {
    return SizedBox(
      width: double.infinity,
      height: isWide ? 420 : 300,
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
            right: isWide ? -20 : -50,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.handshake_outlined,
                color: Colors.white,
                size: isWide ? 360 : 240,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 100 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4), width: 2),
                    ),
                    child: const Center(
                      child: Icon(Icons.handshake_outlined,
                          color: Colors.white, size: 38),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Our Partners",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.poppinsBold,
                      fontSize: isWide ? 44 : 26,
                      letterSpacing: 0.5,
                      shadows: const [
                        Shadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 3)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Trusted International Suppliers Powering Agriculture Across Ghana",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: AppFonts.poppinsLight,
                      fontSize: isWide ? 18 : 13,
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

  Widget _buildIntro(bool isWide) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 60 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Trusted Partnerships, Quality Products",
            style: TextStyle(
              color: AppColors.gradient2,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 28,
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
          const SizedBox(height: 22),
          const Text(
            "Frankatson Ghana Limited is proud to work alongside some of the world's leading manufacturers and suppliers of veterinary pharmaceuticals, agrochemicals, and poultry equipment. These partnerships allow us to bring premium, industry-trusted products directly to farmers and agricultural businesses across Ghana and the West African sub-region.",
            style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.8),
          ),
          const SizedBox(height: 16),
          const Text(
            "Our international partners are carefully selected based on their commitment to quality, innovation, and sustainable agricultural practices — ensuring that our customers always receive products that meet the highest global standards.",
            style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.8),
          ),
          const SizedBox(height: 28),
          _buildCountriesRow(isWide),
        ],
      ),
    );
  }

  Widget _buildCountriesRow(bool isWide) {
    const countries = [
      (Icons.flag_outlined, "Spain"),
      (Icons.flag_outlined, "Holland"),
      (Icons.flag_outlined, "United Kingdom"),
      (Icons.flag_outlined, "USA"),
      (Icons.flag_outlined, "Italy"),
      (Icons.flag_outlined, "France"),
      (Icons.flag_outlined, "China"),
      (Icons.flag_outlined, "India"),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: countries
          .map(
            (c) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gradient2.withValues(alpha: 0.07),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: AppColors.gradient2.withValues(alpha: 0.25),
                    width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(c.$1,
                      size: 14,
                      color: AppColors.gradient2.withValues(alpha: 0.7)),
                  const SizedBox(width: 6),
                  Text(
                    c.$2,
                    style: const TextStyle(
                      color: AppColors.gradient2,
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPartnersGrid(bool isWide, PartnersViewModel viewModel) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 60 : 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Our International Suppliers",
            style: TextStyle(
              color: AppColors.gradient2,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 26,
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
          const SizedBox(height: 36),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: List.generate(
                viewModel.partnerImages.length,
                (i) => _PartnerCard(
                  image: viewModel.partnerImages[i],
                  name: viewModel.partnerNames[i],
                  isWide: isWide,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PartnersViewModel viewModelBuilder(BuildContext context) =>
      PartnersViewModel();
}

class _PartnerCard extends StatefulWidget {
  final String image;
  final String name;
  final bool isWide;

  const _PartnerCard({
    required this.image,
    required this.name,
    required this.isWide,
  });

  @override
  State<_PartnerCard> createState() => _PartnerCardState();
}

class _PartnerCardState extends State<_PartnerCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.isWide ? 120.0 : 80.0;
    final cardW = widget.isWide ? 180.0 : 140.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardW,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.gradient2.withValues(alpha: 0.18)
                  : Colors.grey.withValues(alpha: 0.1),
              blurRadius: _hovered ? 20 : 12,
              spreadRadius: _hovered ? 3 : 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: _hovered
                    ? AppColors.gradient2.withValues(alpha: 0.06)
                    : Colors.transparent,
              ),
              child: Center(
                child: Image.asset(
                  widget.image,
                  width: size * 0.85,
                  height: size * 0.85,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.poppinsMedium,
                fontSize: widget.isWide ? 13 : 11,
                color: _hovered ? AppColors.gradient2 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
