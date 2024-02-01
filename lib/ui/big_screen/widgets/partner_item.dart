import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frankoweb/constants/fonts.dart';

class PartnerItem extends StatelessWidget {
  final String image;
  final String name;
  const PartnerItem({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      // height: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Image.asset(
                    image,
                    width: 120,
                    height: 120,
                  ),
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: AppFonts.poppinsMedium, fontSize: 14),
          )
        ],
      ),
    );
  }
}
