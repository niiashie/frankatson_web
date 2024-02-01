import 'package:flutter/widgets.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';

class Heading extends StatelessWidget {
  final String title;
  const Heading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.gradient2,
              fontSize: 30,
              fontFamily: AppFonts.poppinsBold),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 50,
          height: 2,
          decoration: const BoxDecoration(
              color: AppColors.gradient1,
              borderRadius: BorderRadius.all(Radius.circular(1))),
        ),
      ],
    );
  }
}
