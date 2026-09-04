import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/constants/routes.dart';
import 'package:frankoweb/ui/big_screen/widgets/nav_menu_item.dart';
import 'package:frankoweb/ui/shared/account_menu.dart';
import 'dart:html' as html;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BigAppBar extends StatefulWidget {
  final VoidCallback aboutUsClicked;
  final VoidCallback servicesClicked;
  final VoidCallback partnersClicked;
  final VoidCallback teamClicked;
  final VoidCallback blogClicked;
  final VoidCallback facebookClicked;
  final VoidCallback linkedInClicked;
  final VoidCallback instagramClicked;
  final bool aboutUsSelected;
  final bool serviceSelected;
  final bool partnersSelected;
  final bool teamSelected;
  final bool blogSelected;
  final bool isScrolled;
  const BigAppBar(
      {super.key,
      required this.aboutUsClicked,
      required this.servicesClicked,
      required this.partnersClicked,
      required this.teamClicked,
      required this.facebookClicked,
      required this.linkedInClicked,
      required this.instagramClicked,
      required this.blogClicked,
      this.aboutUsSelected = false,
      this.serviceSelected = false,
      this.partnersSelected = false,
      this.teamSelected = false,
      this.blogSelected = false,
      this.isScrolled = false});

  @override
  State<BigAppBar> createState() => _BigAppBarState();
}

class _BigAppBarState extends State<BigAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Stack(
        children: [
          // Logo + brand name — left
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width >= 800 ? 50 : 30,
                    height: MediaQuery.of(context).size.width >= 800 ? 50 : 30,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        AppImages.logo,
                        width:
                            MediaQuery.of(context).size.width >= 800 ? 50 : 30,
                        height:
                            MediaQuery.of(context).size.width >= 800 ? 50 : 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Frankatson",
                  style: TextStyle(
                      color: AppColors.gradient2,
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize:
                          MediaQuery.of(context).size.width >= 800 ? 25 : 18),
                )
              ],
            ),
          ),
          // Nav menu items — centered (desktop only)
          if (MediaQuery.of(context).size.width >= 800)
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NavMenuItem(
                    title: 'About us',
                    selected: widget.aboutUsSelected,
                    isScrolled: true,
                    onTap: () {
                      widget.aboutUsClicked();
                    },
                    width: 100,
                  ),
                  const SizedBox(width: 5),
                  NavMenuItem(
                    title: 'Services',
                    selected: widget.serviceSelected,
                    isScrolled: true,
                    onTap: () {
                      widget.servicesClicked();
                    },
                    width: 100,
                  ),
                  const SizedBox(width: 5),
                  NavMenuItem(
                    title: 'Partners',
                    selected: widget.partnersSelected,
                    isScrolled: true,
                    onTap: () {
                      widget.partnersClicked();
                    },
                    width: 100,
                  ),
                  const SizedBox(width: 5),
                  NavMenuItem(
                    title: 'Team',
                    selected: widget.teamSelected,
                    isScrolled: true,
                    onTap: () {
                      widget.teamClicked();
                    },
                    width: 70,
                  ),
                  const SizedBox(width: 5),
                  NavMenuItem(
                    title: 'Posts',
                    selected: false,
                    isScrolled: true,
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.postsScreen);
                    },
                    width: 80,
                  ),
                ],
              ),
            ),
          // Social icons + user menu — right
          Align(
            alignment: Alignment.centerRight,
            child: MediaQuery.of(context).size.width >= 800
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.facebook,
                          size: 25,
                          color: AppColors.gradient2,
                        ),
                        onTap: () {
                          html.window.open(
                              'https://web.facebook.com/profile.php?id=100063269766759',
                              "_blank");
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.linkedin,
                          size: 25,
                          color: AppColors.gradient2,
                        ),
                        onTap: () {
                          html.window.open(
                              'https://www.linkedin.com/company/frankatson/mycompany/',
                              "_blank");
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.instagram,
                          size: 25,
                          color: AppColors.gradient2,
                        ),
                        onTap: () {
                          html.window.open(
                              'https://www.instagram.com/frankatson/?hl=en',
                              "_blank");
                        },
                      ),
                      const AccountMenu(),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.facebook,
                          size: 20,
                          color: AppColors.gradient2,
                        ),
                        onTap: () {
                          html.window.open(
                              'https://web.facebook.com/profile.php?id=100063269766759',
                              "_blank");
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.linkedin,
                          size: 20,
                          color: AppColors.gradient2,
                        ),
                        onTap: () {
                          html.window.open(
                              'https://www.linkedin.com/company/frankatson/mycompany/',
                              "_blank");
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.instagram,
                          size: 20,
                          color: AppColors.gradient2,
                        ),
                        onTap: () {
                          html.window.open(
                              'https://www.instagram.com/frankatson/?hl=en',
                              "_blank");
                        },
                      ),
                      const AccountMenu(iconSize: 22),
                      PopupMenuButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.list,
                          color: AppColors.gradient2,
                          size: 25,
                        ),
                        offset: const Offset(0.0, 60),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        onSelected: (value) {
                          if (value == "aboutUs") {
                            widget.aboutUsClicked();
                          } else if (value == "services") {
                            widget.servicesClicked();
                          } else if (value == "partners") {
                            widget.partnersClicked();
                          } else if (value == "team") {
                            widget.teamClicked();
                          } else if (value == "posts") {
                            Navigator.of(context).pushNamed(Routes.postsScreen);
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: "aboutUs",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(child: Text("About Us")),
                            ),
                          ),
                          PopupMenuItem(
                            value: "services",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(child: Text("Services")),
                            ),
                          ),
                          PopupMenuItem(
                            value: "partners",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(child: Text("Partners")),
                            ),
                          ),
                          PopupMenuItem(
                            value: "team",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(child: Text("Team")),
                            ),
                          ),
                          PopupMenuItem(
                            value: "posts",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(child: Text("Posts")),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
