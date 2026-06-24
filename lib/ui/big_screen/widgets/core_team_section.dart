import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/shared/hover_image.dart';

class CoreTeamSection extends StatelessWidget {
  final Key? sectionKey;

  const CoreTeamSection({super.key, this.sectionKey});

  Widget _mobileRow(List<String> images, List<String> names, List<String> roles) {
    return Container(
      width: double.infinity,
      height: 170,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: List.generate(
          images.length,
          (i) => Expanded(
            child: HoverImage(image: images[i], name: names[i], role: roles[i]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 800;

    return Container(
      key: sectionKey,
      width: double.infinity,
      height: isWide ? 700 : 800,
      color: Colors.white,
      child: Stack(
        children: [
          Container(width: double.infinity, height: 350, color: AppColors.lightCradient1),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Core Team",
                  style: TextStyle(
                    color: AppColors.gradient2,
                    fontSize: 30,
                    fontFamily: AppFonts.poppinsBold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 50,
                  height: 2,
                  decoration: const BoxDecoration(
                    color: AppColors.gradient1,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                ),
                const SizedBox(height: 20),
                if (isWide) ...[
                  SizedBox(
                    width: w / 1.2,
                    height: 300,
                    child: const Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: HoverImage(image: AppImages.director, name: 'Mr Kwadwo Boakye', role: 'Managing Director')),
                        Expanded(child: HoverImage(image: AppImages.direcKum, name: 'Mr Kwame Boakye', role: 'Deputy Managing Director')),
                        Expanded(child: HoverImage(image: AppImages.joyce, name: 'Mrs Joyce Ofori', role: 'General Manager')),
                        Expanded(child: HoverImage(image: AppImages.ceo, name: 'Mr Micheal Amofa Boateng', role: 'Finance Manager')),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w / 1.2,
                    height: 300,
                    child: const Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: HoverImage(image: AppImages.frimpong, name: 'Dr Victor Frimpong', role: 'VET. Sales Officer(Accra)')),
                        Expanded(child: HoverImage(image: AppImages.sefa, name: 'Dr Felix Sefa Boachie', role: 'VET. Sales Officer(Kumasi)')),
                        Expanded(child: HoverImage(image: AppImages.charlotte, name: 'Dr Charlotte Oppong', role: 'VET. Sales Officer(Accra)')),
                        Expanded(child: HoverImage(image: AppImages.christian, name: 'Christian Odoom', role: 'AGRO Sales ManagerF')),
                      ],
                    ),
                  ),
                ] else ...[
                  _mobileRow([AppImages.director, AppImages.direcKum], ['Mr Kwadwo Boakye', 'Mr Kwame Boakye'], ['Managing Director', 'Deputy Managing Director']),
                  _mobileRow([AppImages.joyce, AppImages.ceo], ['Mrs Joyce Ofori', 'Mr Micheal Amofa Boateng'], ['General Manager', 'Finance Manager']),
                  _mobileRow([AppImages.frimpong, AppImages.sefa], ['Dr Victor Frimpong', 'Dr Sefa Boachie'], ['VET. Sales Officer(Accra)', 'VET. Sales Officer(Kumasi)']),
                  _mobileRow([AppImages.charlotte, AppImages.christian], ['Dr Charlotte Oppong', 'Christian Odoom'], ['VET. Sales Officer(Accra)', 'AGRO Sales Manager']),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
