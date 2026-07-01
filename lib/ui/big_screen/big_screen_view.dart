import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/routes.dart';
import 'package:frankoweb/ui/big_screen/big_screen_view_model.dart';
import 'package:frankoweb/ui/big_screen/widgets/about_section.dart';
import 'package:frankoweb/ui/big_screen/widgets/contact_section.dart';
import 'package:frankoweb/ui/big_screen/widgets/core_team_section.dart';
import 'package:frankoweb/ui/big_screen/widgets/gallery_section.dart';
import 'package:frankoweb/ui/big_screen/widgets/hero_section.dart';
import 'package:frankoweb/ui/big_screen/widgets/partners_section.dart';
import 'package:frankoweb/ui/big_screen/widgets/services_section.dart';
import 'package:frankoweb/ui/shared/big_app_bar.dart';
import 'package:frankoweb/ui/shared/footer.dart';
import 'package:stacked/stacked.dart';

class BigScreenView extends StackedView<BigScreenViewModel> {
  final String? menu;
  const BigScreenView({this.menu, Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(BigScreenViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: viewModel.scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 100),
                  HeroSection(
                    sectionKey: viewModel.key0,
                    onServicesClicked: viewModel.serviceClicked,
                    onContactClicked: viewModel.contactUsClicked,
                  ),
                  AboutSection(sectionKey: viewModel.key1),
                  ServicesSection(sectionKey: viewModel.key2),
                  PartnersSection(
                    sectionKey: viewModel.key3,
                    partnerImages: viewModel.partnerImages.take(6).toList(),
                    partnerNames: viewModel.partnerNames.take(6).toList(),
                    onViewMore: () => Navigator.of(context)
                        .pushNamed(Routes.partnersScreen),
                  ),
                  CoreTeamSection(sectionKey: viewModel.key4),
                  GallerySection(images: viewModel.galleryImages),
                  ContactSection(sectionKey: viewModel.key5),
                  const Footer(),
                ],
              ),
            ),
            Visibility(
              visible: viewModel.showScrollUp,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    elevation: 5,
                    child: InkWell(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: AppColors.gradient1,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_double_arrow_up,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      onTap: viewModel.moveUp,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              decoration: BoxDecoration(
                color: viewModel.isScrolled
                    ? Colors.white.withValues(alpha: 0.97)
                    : Colors.transparent,
                boxShadow: viewModel.isScrolled
                    ? [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              child: BigAppBar(
                isScrolled: viewModel.isScrolled,
                aboutUsClicked: viewModel.aboutUsClicked,
                servicesClicked: viewModel.serviceClicked,
                teamClicked: viewModel.teamClicked,
                partnersClicked: viewModel.partnersClicked,
                facebookClicked: () {},
                linkedInClicked: () {},
                blogClicked: () =>
                    Navigator.of(context).pushNamed(Routes.blogScreen),
                instagramClicked: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BigScreenViewModel viewModelBuilder(BuildContext context) =>
      BigScreenViewModel();
}
