import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GallerySlider extends StatefulWidget {
  final List<String> images;
  const GallerySlider({super.key, required this.images});

  @override
  State<GallerySlider> createState() => _GallerySliderState();
}

class _GallerySliderState extends State<GallerySlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      color: Colors.white,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
            ),
            items: widget.images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Material(
                    elevation: 2,
                    color: const Color.fromRGBO(0, 0, 0, 0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            i,
                            width: double.infinity,
                            height: 380,
                            fit: BoxFit.fill,
                          ),
                        )),
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
