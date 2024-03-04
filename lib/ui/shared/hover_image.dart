import 'package:flutter/material.dart';
import 'package:frankoweb/constants/fonts.dart';

class HoverImage extends StatefulWidget {
  final String image;
  final String name;
  final String role;

  const HoverImage({
    required this.image,
    required this.name,
    required this.role,
  });

  @override
  _HoverImageState createState() => _HoverImageState();
}

class _HoverImageState extends State<HoverImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Animation padding;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    padding = Tween(begin: 0.0, end: -25.0).animate(CurvedAnimation(
        parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MouseRegion(
          onEnter: (value) {
            setState(() {
              _controller.forward();
            });
          },
          onExit: (value) {
            setState(() {
              _controller.reverse();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  // color: Colors.black26,
                  // offset: Offset(0.0, 15.0),
                  // spreadRadius: -10.0,
                  // blurRadius: 15.0,
                  color: Colors.grey[400]!,
                  blurRadius: 7.0,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Container(
              height: MediaQuery.of(context).size.width >= 800 ? 200.0 : 100,
              width: MediaQuery.of(context).size.width >= 800 ? 200.0 : 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              clipBehavior: Clip.hardEdge,
              transform: Matrix4(_animation.value, 0, 0, 0, 0, _animation.value,
                  0, 0, 0, 0, 1, 0, padding.value, padding.value, 0, 1),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          widget.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: AppFonts.poppinsMedium,
              fontSize: MediaQuery.of(context).size.width >= 800 ? 15 : 12),
        ),
        Text(
          widget.role,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width >= 800 ? 13 : 11),
        )
      ],
    );
  }
}
