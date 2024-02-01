import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.width >= 800 ? 400 : 750,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.gradient2,
            AppColors.gradient1,
          ],
        )),
        child: Stack(
          children: [
            Visibility(
              visible: MediaQuery.of(context).size.width >= 800 ? true : false,
              replacement: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              AppImages.logo,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Follow us on",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: InkWell(
                                  child: const Icon(
                                    Icons.facebook,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: InkWell(
                                  child: Icon(
                                    MdiIcons.linkedin,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: InkWell(
                                  child: Icon(
                                    MdiIcons.instagram,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Contact",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.poppinsMedium,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Container(width: 30, height: 1, color: Colors.white),
                          const SizedBox(height: 10),
                          InkWell(
                            child: const Text(
                              "Mail Us",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "0302224085 / 0302233722",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mail,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "fboachie@yahoo.com",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Frankatson",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.poppinsMedium,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Container(width: 30, height: 1, color: Colors.white),
                          const SizedBox(height: 10),
                          InkWell(
                            child: const Text(
                              "News",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            child: const Text(
                              "Partners",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            child: const Text(
                              "Blogs",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            child: const Text(
                              "Products",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "My Account",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.poppinsMedium,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Container(width: 30, height: 1, color: Colors.white),
                          const SizedBox(height: 10),
                          InkWell(
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            child: const Text(
                              "Create Account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            elevation: 2,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  AppImages.logo,
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Follow us on",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 120,
                            height: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: const Icon(
                                    Icons.facebook,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: Icon(
                                    MdiIcons.linkedin,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: Icon(
                                    MdiIcons.instagram,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Contact",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.poppinsMedium,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 5),
                            Container(
                                width: 30, height: 1, color: Colors.white),
                            const SizedBox(height: 22),
                            InkWell(
                              child: const Text(
                                "Mail Us",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "0302224085 / 0302233722",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "fboachie@yahoo.com",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Frankatson",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.poppinsMedium,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 5),
                            Container(
                                width: 30, height: 1, color: Colors.white),
                            const SizedBox(height: 22),
                            InkWell(
                              child: const Text(
                                "News",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: const Text(
                                "Partners",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: const Text(
                                "Blogs",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: const Text(
                                "Products",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: const Text(
                                "Gallery",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "My Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.poppinsMedium,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 5),
                            Container(
                                width: 30, height: 1, color: Colors.white),
                            const SizedBox(height: 22),
                            InkWell(
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copyright,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "2024 Frankatson | All rights reserved",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
