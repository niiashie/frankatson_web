import 'package:flutter/material.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/big_screen/widgets/nav_menu_item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      this.blogSelected = false});

  @override
  State<BigAppBar> createState() => _BigAppBarState();
}

class _BigAppBarState extends State<BigAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      //color: Colors.amber,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Stack(
        children: [
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
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Frankatson",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize:
                          MediaQuery.of(context).size.width >= 800 ? 25 : 18),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: MediaQuery.of(context).size.width >= 800
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NavMenuItem(
                        title: 'About us',
                        selected: widget.aboutUsSelected,
                        onTap: () {
                          widget.aboutUsClicked();
                        },
                        width: 100,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      NavMenuItem(
                        title: 'Services',
                        selected: widget.serviceSelected,
                        onTap: () {
                          widget.servicesClicked();
                        },
                        width: 100,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      NavMenuItem(
                        title: 'Partners',
                        selected: widget.partnersSelected,
                        onTap: () {
                          widget.partnersClicked();
                        },
                        width: 100,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      NavMenuItem(
                        title: 'Team',
                        selected: widget.teamSelected,
                        onTap: () {
                          widget.teamClicked();
                        },
                        width: 70,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      NavMenuItem(
                        title: 'Blog',
                        selected: widget.blogSelected,
                        onTap: () {
                          widget.blogClicked();
                        },
                        width: 60,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
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
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.facebook,
                          size: 20,
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
                          size: 20,
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
                          size: 20,
                          color: Colors.white,
                        ),
                        onTap: () {},
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      PopupMenuButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.list,
                          color: Colors.white,
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
                          } else if (value == "blog") {
                            widget.blogClicked();
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: "aboutUs",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("About Us"),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: "services",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("Services"),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: "partners",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("Partners"),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: "team",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("Team"),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: "blog",
                            padding: EdgeInsets.zero,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("Blog"),
                              ),
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
