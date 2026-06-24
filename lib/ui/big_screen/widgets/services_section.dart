import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/constants/service_content.dart';
import 'package:frankoweb/constants/texts.dart';
import 'package:frankoweb/ui/big_screen/widgets/service_item.dart';
import 'package:frankoweb/ui/services/service_detail_view.dart';

class ServicesSection extends StatelessWidget {
  final Key? sectionKey;

  const ServicesSection({super.key, this.sectionKey});

  void _openDetail(BuildContext context, ServiceDetailView view) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => view));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 800;
    final itemWidth = isWide ? 300.0 : 350.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      color: Colors.white,
      child: Column(
        key: sectionKey,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text(
            "Our Services",
            style: TextStyle(
              color: AppColors.gradient2,
              fontSize: 30,
              fontFamily: AppFonts.poppinsBold,
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
          const SizedBox(height: 40),
          Container(
            width: isWide ? w / 1.2 : double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ServiceItem(
                    width: itemWidth,
                    height: 450,
                    image: AppImages.vet,
                    title: "Veterinary Products",
                    description: AppTexts.veterinaryDescription,
                    onLearnMore: () => _openDetail(
                      context,
                      const ServiceDetailView(
                        title: "Veterinary Products",
                        headline: VetContent.headline,
                        introParagraphs: [VetContent.intro1, VetContent.intro2],
                        bulletSectionTitle: VetContent.bulletTitle,
                        bullets: VetContent.bullets,
                        conclusionText: VetContent.conclusion,
                        iconImage: AppImages.vet,
                        featurePhoto: AppImages.animals,
                      ),
                    ),
                  ),
                  ServiceItem(
                    width: itemWidth,
                    height: 450,
                    image: AppImages.agro,
                    title: "Agro Chemicals",
                    description: AppTexts.agroDescription,
                    onLearnMore: () => _openDetail(
                      context,
                      const ServiceDetailView(
                        title: "Agro Chemicals",
                        headline: AgroContent.headline,
                        introParagraphs: [AgroContent.intro1, AgroContent.intro2],
                        bulletSectionTitle: AgroContent.bulletTitle,
                        bullets: AgroContent.bullets,
                        conclusionText: AgroContent.conclusion,
                        iconImage: AppImages.agro,
                        featurePhoto: AppImages.aboutUs,
                      ),
                    ),
                  ),
                  ServiceItem(
                    width: itemWidth,
                    height: 450,
                    image: AppImages.lab,
                    title: "Laboratory Services",
                    description: AppTexts.labDescription,
                    onLearnMore: () => _openDetail(
                      context,
                      const ServiceDetailView(
                        title: "Laboratory Services",
                        headline: LabContent.headline,
                        introParagraphs: [LabContent.intro1, LabContent.intro2],
                        bulletSectionTitle: LabContent.bulletTitle,
                        bullets: LabContent.bullets,
                        conclusionText: LabContent.conclusion,
                        iconImage: AppImages.lab,
                      ),
                    ),
                  ),
                  ServiceItem(
                    width: itemWidth,
                    height: 450,
                    iconData: Icons.agriculture_outlined,
                    title: "Farm Implements",
                    description: AppTexts.farmImplementsDescription,
                    onLearnMore: () => _openDetail(
                      context,
                      const ServiceDetailView(
                        title: "Farm Implements",
                        headline: FarmImplementsContent.headline,
                        introParagraphs: [
                          FarmImplementsContent.intro1,
                          FarmImplementsContent.intro2,
                        ],
                        bulletSectionTitle: FarmImplementsContent.bulletTitle,
                        bullets: FarmImplementsContent.bullets,
                        conclusionText: FarmImplementsContent.conclusion,
                        iconData: Icons.agriculture_outlined,
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
}
