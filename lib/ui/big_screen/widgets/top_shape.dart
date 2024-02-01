import 'package:flutter/material.dart';
import 'package:frankoweb/ui/shared/screen_path.dart';

import '../../../constants/colors.dart';

class TopShape extends StatelessWidget {
  const TopShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width >= 800 ? 700 : 600,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 700,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppColors.gradient2,
                    AppColors.gradient1,
                  ],
                )),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: ClipPath(
                        clipper: TopScreenPath(),
                        child: Container(
                          width: double.infinity,
                          height: 260,
                          color: Colors.white,
                        )),
                  ))
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 400,
          color: Colors.white,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: TopScreenPath(),
              child: Container(
                width: double.infinity,
                height: 200,
                color: AppColors.lightCradient1,
              ),
            ),
          ),
        )
      ],
    );
  }
}
