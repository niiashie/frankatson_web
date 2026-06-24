import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';

class ServiceItem extends StatefulWidget {
  final double width;
  final double height;
  final String? image;
  final IconData? iconData;
  final String title;
  final String description;
  final VoidCallback? onLearnMore;
  const ServiceItem(
      {super.key,
      required this.width,
      required this.height,
      this.image,
      this.iconData,
      required this.title,
      required this.description,
      this.onLearnMore});

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
        color: hovered ? AppColors.lightCradient1 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: hovered
                ? Colors.grey[300]!
                : Colors.grey[400]!,
            blurRadius: hovered ? 18.0 : 7.0,
            spreadRadius: hovered ? 4 : 1,
          )
        ],
      ),
      child: InkWell(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.gradient1, AppColors.gradient2],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: widget.iconData != null
                      ? Icon(widget.iconData, color: Colors.white, size: 42)
                      : ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                          child: Image.asset(
                            widget.image!,
                            width: 42,
                            height: 42,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: AppFonts.poppinsMedium,
                    color: Colors.black87,
                    letterSpacing: 0.3),
              ),
              const SizedBox(height: 12),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.5,
                  height: 1.65,
                ),
              ),
              const Expanded(child: SizedBox()),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.gradient2,
                    width: 1.5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: hovered ? AppColors.gradient2 : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "Learn More",
                    style: TextStyle(
                      fontFamily: AppFonts.poppinsMedium,
                      color: hovered ? Colors.white : AppColors.gradient2,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        onHover: (a) {
          setState(() {
            hovered = a;
          });
        },
        onTap: widget.onLearnMore,
      ),
    );
  }
}
