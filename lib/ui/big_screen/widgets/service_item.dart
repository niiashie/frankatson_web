import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';

class ServiceItem extends StatefulWidget {
  final double width;
  final double height;
  final String image;
  final String title;
  final String description;
  const ServiceItem(
      {super.key,
      required this.width,
      required this.height,
      required this.image,
      required this.title,
      required this.description});

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 7.0,
            spreadRadius: hovered == false ? 1 : 10, //New
          )
        ],
      ),
      child: InkWell(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: AppColors.lightCradient1, shape: BoxShape.circle),
                child: Center(
                  child: Image.asset(
                    widget.image,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: AppFonts.poppinsMedium,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 17),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Material(
                color: AppColors.gradient2,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                elevation: 2,
                child: InkWell(
                  child: Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Center(
                        child: Text(
                          "Details",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsMedium,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      )),
                  onTap: () {
                    debugPrint("Services tapped");
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        onHover: (a) {
          setState(() {
            hovered = a;
          });
        },
        onTap: () {
          //debugPrint("Tapped");
        },
      ),
    );
  }
}
