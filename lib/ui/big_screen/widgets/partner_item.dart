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
                width: MediaQuery.of(context).size.width >= 800 ? 150 : 100,
                height: MediaQuery.of(context).size.width >= 800 ? 150 : 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(10),
                // Partner logos range from square to 2:1 — `contain` keeps the
                // wide ones whole instead of cropping them to the box.
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
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
