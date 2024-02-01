import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/constants/texts.dart';
import 'package:frankoweb/ui/about_us/about_us_view_model.dart';
import 'package:frankoweb/ui/shared/heading.dart';
import 'package:stacked/stacked.dart';

class AboutUsView extends StackedView<AboutUsViewModel> {
  const AboutUsView({
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(AboutUsViewModel viewModel) async {
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Material(
                                  elevation: 5,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Image.asset(
                                        AppImages.logo,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      MediaQuery.of(context).size.width >= 800
                                          ? true
                                          : false,
                                  child: const SizedBox(
                                    width: 10,
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        MediaQuery.of(context).size.width >= 800
                                            ? true
                                            : false,
                                    child: const Text(
                                      "Frankatson",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: AppFonts.poppinsMedium,
                                          fontSize: 25),
                                    ))
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width >=
                                                    800
                                                ? 18
                                                : 14),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 17,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppFonts.poppinsMedium,
                                      fontSize:
                                          MediaQuery.of(context).size.width >=
                                                  800
                                              ? 30
                                              : 20),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: PopupMenuButton(
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
                                if (value == "login") {
                                } else if (value == "news") {
                                } else if (value == "blog") {}
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: "login",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Center(
                                      child: Text("Login"),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "news",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Center(
                                      child: Text("News"),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "blog",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Center(
                                      child: Text("Blogs"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Heading(
                          title: "Our Story",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width >= 800
                                ? 700
                                : double.infinity,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width >=
                                            800
                                        ? 345
                                        : double.infinity,
                                    height: 300,
                                    padding: const EdgeInsets.all(5),
                                    margin:
                                        MediaQuery.of(context).size.width >= 800
                                            ? EdgeInsets.zero
                                            : const EdgeInsets.only(
                                                left: 20, right: 20),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Container(
                                          width: 250,
                                          height: 250,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Image.asset(
                                            AppImages.francisBoachie,
                                            width: 250,
                                            height: 250,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width >= 800
                                          ? 345
                                          : double.infinity,
                                  height: 300,
                                  margin:
                                      MediaQuery.of(context).size.width >= 800
                                          ? EdgeInsets.zero
                                          : const EdgeInsets.only(
                                              left: 20, right: 20),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppTexts.aboutUs1,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        AppTexts.aboutUs2,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 110,
                                  margin:
                                      MediaQuery.of(context).size.width >= 800
                                          ? EdgeInsets.zero
                                          : const EdgeInsets.only(
                                              left: 20, right: 20),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${AppTexts.aboutUs3} ${AppTexts.aboutUs4}",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  @override
  AboutUsViewModel viewModelBuilder(BuildContext context) => AboutUsViewModel();
}
