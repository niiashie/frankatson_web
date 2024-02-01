import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';

class NavMenuItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final double width;
  final bool? selected;
  const NavMenuItem(
      {super.key,
      required this.title,
      required this.onTap,
      this.selected = false,
      required this.width});

  @override
  State<NavMenuItem> createState() => _NavMenuItemState();
}

class _NavMenuItemState extends State<NavMenuItem> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: 40,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: widget.selected == true
              ? Colors.white
              : selected
                  ? Colors.white
                  : Colors.transparent,
          borderRadius: widget.selected == true
              ? const BorderRadius.all(Radius.circular(20))
              : selected
                  ? const BorderRadius.all(Radius.circular(20))
                  : const BorderRadius.all(Radius.zero)),
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                color: widget.selected == true
                    ? AppColors.gradient2
                    : selected
                        ? AppColors.gradient2
                        : Colors.white,
                fontFamily: AppFonts.poppinsMedium,
                fontSize: 15),
          ),
        ),
        onHover: (a) {
          setState(() {
            selected = a;
          });
        },
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }
}
