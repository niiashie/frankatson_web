import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/constants/routes.dart';
import 'package:frankoweb/constants/texts.dart';
import 'package:frankoweb/ui/big_screen/big_screen_view_model.dart';
import 'package:frankoweb/ui/big_screen/widgets/partner_item.dart';
import 'package:frankoweb/ui/big_screen/widgets/service_item.dart';
import 'package:frankoweb/ui/big_screen/widgets/top_shape.dart';
import 'package:frankoweb/ui/shared/big_app_bar.dart';
import 'package:frankoweb/ui/shared/footer.dart';
import 'package:frankoweb/ui/shared/gallery_slider.dart';
import 'package:frankoweb/ui/shared/hover_image.dart';
import 'package:stacked/stacked.dart';

class BigScreenView extends StackedView<BigScreenViewModel> {
  final String? menu;
  const BigScreenView({
    this.menu,
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(BigScreenViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: viewModel.scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          key: viewModel.key0,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width >= 800
                              ? 1200
                              : 1500,
                          color: AppColors.lightCradient1,
                          child: Stack(
                            children: [
                              const TopShape(),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: BigAppBar(
                                    aboutUsClicked: () {
                                      viewModel.aboutUsClicked();
                                    },
                                    servicesClicked: () {
                                      viewModel.serviceClicked();
                                    },
                                    teamClicked: () {
                                      viewModel.teamClicked();
                                    },
                                    partnersClicked: () {
                                      viewModel.partnersClicked();
                                    },
                                    facebookClicked: () {},
                                    linkedInClicked: () {},
                                    blogClicked: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.blogScreen);
                                    },
                                    instagramClicked: () {},
                                  )),
                              Visibility(
                                visible:
                                    MediaQuery.of(context).size.width >= 800
                                        ? true
                                        : false,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 170),
                                    child: Image.asset(
                                      AppImages.animals,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 400,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment:
                                      MediaQuery.of(context).size.width >= 800
                                          ? Alignment.topLeft
                                          : Alignment.topCenter,
                                  child: Padding(
                                    padding:
                                        MediaQuery.of(context).size.width >= 800
                                            ? const EdgeInsets.only(
                                                top: 150, left: 30)
                                            : const EdgeInsets.only(top: 150),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          MediaQuery.of(context).size.width >=
                                                  800
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sort Out All",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >=
                                                      800
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30
                                                  : 30),
                                        ),
                                        Text(
                                          "Your Veterinary And",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >=
                                                      800
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30
                                                  : 30),
                                        ),
                                        Text(
                                          "Farming Issues With",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >=
                                                      800
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30
                                                  : 30),
                                        ),
                                        Text(
                                          "The Farmer's Friend",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >=
                                                      800
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30
                                                  : 30),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Material(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                              elevation: 2,
                                              child: InkWell(
                                                child: Container(
                                                  width: 170,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25)),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "View Services",
                                                      style: TextStyle(
                                                          fontFamily: AppFonts
                                                              .poppinsMedium,
                                                          color: AppColors
                                                              .gradient2),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  viewModel.serviceClicked();
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Material(
                                              color: AppColors.gradient2,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                              elevation: 2,
                                              child: InkWell(
                                                child: Container(
                                                  width: 170,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25)),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Contact Us",
                                                      style: TextStyle(
                                                          fontFamily: AppFonts
                                                              .poppinsMedium,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  viewModel.contactUsClicked();
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    child: Column(
                                      key: viewModel.key1,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "About Us",
                                          style: TextStyle(
                                              color: AppColors.gradient2,
                                              fontSize: 30,
                                              fontFamily: AppFonts.poppinsBold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 50,
                                          height: 2,
                                          decoration: const BoxDecoration(
                                              color: AppColors.gradient1,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1))),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width >=
                                                  800
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.3
                                              : double.infinity,
                                          margin: MediaQuery.of(context)
                                                      .size
                                                      .width >=
                                                  800
                                              ? const EdgeInsets.all(0)
                                              : const EdgeInsets.only(
                                                  left: 20, right: 20),
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Wrap(
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >=
                                                        800
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.7
                                                    : double.infinity,
                                                height: 400,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width >=
                                                                800
                                                            ? CrossAxisAlignment
                                                                .start
                                                            : CrossAxisAlignment
                                                                .center,
                                                    children: [
                                                      const Text(
                                                        AppTexts.aboutUs1,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Text(
                                                        AppTexts.aboutUs2,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Material(
                                                        color:
                                                            AppColors.gradient2,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    25)),
                                                        elevation: 2,
                                                        child: InkWell(
                                                          child: Container(
                                                            width: 170,
                                                            height: 50,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                            ),
                                                            child: const Center(
                                                                child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Read More",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          AppFonts
                                                                              .poppinsMedium,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                SizedBox(
                                                                    width: 5),
                                                                Icon(
                                                                  Icons
                                                                      .chevron_right,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            )),
                                                          ),
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(Routes
                                                                    .aboutUsScreen);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width >=
                                                          800
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2.7
                                                      : double.infinity,
                                                  height: 400,
                                                  padding: EdgeInsets.only(
                                                      left: 20,
                                                      top: 20,
                                                      bottom: 20,
                                                      right:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width >=
                                                                  800
                                                              ? 0
                                                              : 20),
                                                  child: Material(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    elevation: 2,
                                                    color: Colors.white,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: Image.asset(
                                                        AppImages.ceo,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          )),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        color: AppColors.lightCradient1,
                        child: Column(
                          key: viewModel.key2,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              "Our Services",
                              style: TextStyle(
                                  color: AppColors.gradient2,
                                  fontSize: 30,
                                  fontFamily: AppFonts.poppinsBold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 50,
                              height: 2,
                              decoration: const BoxDecoration(
                                  color: AppColors.gradient1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1))),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width >= 800
                                    ? MediaQuery.of(context).size.width / 1.2
                                    : double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Center(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      ServiceItem(
                                        width:
                                            MediaQuery.of(context).size.width >=
                                                    800
                                                ? 300
                                                : 350,
                                        height: 450,
                                        image: AppImages.vet,
                                        title: "Veterinary Products",
                                        description:
                                            AppTexts.veterinaryDescription,
                                      ),
                                      ServiceItem(
                                        width:
                                            MediaQuery.of(context).size.width >=
                                                    800
                                                ? 300
                                                : 350,
                                        height: 450,
                                        image: AppImages.agro,
                                        title: "Agro Chemicals",
                                        description: AppTexts.agroDescription,
                                      ),
                                      ServiceItem(
                                        width:
                                            MediaQuery.of(context).size.width >=
                                                    800
                                                ? 300
                                                : 350,
                                        height: 450,
                                        image: AppImages.lab,
                                        title: "Laboratory Services",
                                        description: AppTexts.labDescription,
                                      ),
                                      ServiceItem(
                                        width:
                                            MediaQuery.of(context).size.width >=
                                                    800
                                                ? 300
                                                : 350,
                                        height: 450,
                                        image: AppImages.chick,
                                        title: "Day Old Chicks",
                                        description: AppTexts.chickDescription,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        key: viewModel.key3,
                        height: 400,
                        color: AppColors.lightCradient1,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Our Partners",
                                style: TextStyle(
                                    color: AppColors.gradient2,
                                    fontSize: 30,
                                    fontFamily: AppFonts.poppinsBold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 50,
                                height: 2,
                                decoration: const BoxDecoration(
                                    color: AppColors.gradient1,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1))),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(left: 40),
                                height: 230,
                                child: ListView.builder(
                                    itemCount: viewModel.partnerNames.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return PartnerItem(
                                        image: viewModel.partnerImages[index],
                                        name: viewModel.partnerNames[index],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        key: viewModel.key4,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width >= 800
                            ? 700
                            : 800,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 350,
                              color: AppColors.lightCradient1,
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Core Team",
                                    style: TextStyle(
                                        color: AppColors.gradient2,
                                        fontSize: 30,
                                        fontFamily: AppFonts.poppinsBold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 2,
                                    decoration: const BoxDecoration(
                                        color: AppColors.gradient1,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1))),
                                  ),
                                  const SizedBox(height: 20),
                                  Visibility(
                                    visible:
                                        MediaQuery.of(context).size.width >= 800
                                            ? true
                                            : false,
                                    replacement: Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Kwadwo Boakye',
                                            role: 'Managing Director',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Kwame Boakye',
                                            role: 'Deputy Managing Director',
                                          ))
                                        ],
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height: 300,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Kwadwo Boakye',
                                            role: 'Managing Director',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Kwame Boakye',
                                            role: 'Deputy Managing Director',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Joyce',
                                            role: 'Human Resource Manager',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Amofa Boateng',
                                            role: 'Head Of Accounts',
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        MediaQuery.of(context).size.width >= 800
                                            ? true
                                            : false,
                                    replacement: Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Joyce',
                                            role: 'Human Resource Manager',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Amofa Boateng',
                                            role: 'Head Of Accounts',
                                          ))
                                        ],
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height: 300,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.frimpong,
                                            name: 'Dr Victor Frimpong',
                                            role: 'Veterinary Doctor',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Dr Sefa Boachie',
                                            role: 'Veterinary Doctor',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Dr Charlotte',
                                            role: 'Veterinary Doctor',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.christian,
                                            name: 'Christian Odoom',
                                            role: 'Head Of Agrochemicals',
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        MediaQuery.of(context).size.width >= 800
                                            ? false
                                            : true,
                                    child: Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.frimpong,
                                            name: 'Dr Victor Frimpong',
                                            role: 'Veterinary Doctor',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Dr Sefa Boachie',
                                            role: 'Veterinary Doctor',
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        MediaQuery.of(context).size.width >= 800
                                            ? false
                                            : true,
                                    child: Container(
                                      width: double.infinity,
                                      height: 170,
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.ceo,
                                            name: 'Dr Charlotte',
                                            role: 'Veterinary Doctor',
                                          )),
                                          Expanded(
                                              child: HoverImage(
                                            image: AppImages.christian,
                                            name: 'Christian Odoom',
                                            role: 'Head Of Agrochemicals',
                                          )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Text(
                        "Our Gallery",
                        style: TextStyle(
                            color: AppColors.gradient2,
                            fontSize: 30,
                            fontFamily: AppFonts.poppinsBold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 50,
                        height: 2,
                        decoration: const BoxDecoration(
                            color: AppColors.gradient1,
                            borderRadius: BorderRadius.all(Radius.circular(1))),
                      ),
                      const SizedBox(height: 20),
                      GallerySlider(images: viewModel.galleryImages),
                      Container(
                        key: viewModel.key5,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width >= 800
                            ? 750
                            : 1200,
                        margin: MediaQuery.of(context).size.width >= 800
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(left: 20, right: 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Contact Us",
                              style: TextStyle(
                                  color: AppColors.gradient2,
                                  fontSize: 30,
                                  fontFamily: AppFonts.poppinsBold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 50,
                              height: 2,
                              decoration: const BoxDecoration(
                                  color: AppColors.gradient1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1))),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "We have two major branches in Ghana, one in the Ashanti Region and the other in the capital city.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Accra Branch",
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsMedium,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Visibility(
                              visible: MediaQuery.of(context).size.width >= 800
                                  ? true
                                  : false,
                              replacement: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[400]!,
                                        blurRadius: 3.0,
                                        spreadRadius: 1)
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: AppColors.gradient2,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              size: 27,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Address:",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsMedium),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("No 28 Orgle Road North"),
                                        const Text("Kaneshie Accra Ghana")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: AppColors.gradient2,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.email_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Email:",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsMedium),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("fboachie@yahoo.com"),
                                        const Text("")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: AppColors.gradient2,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.phone_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Phone:",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsMedium),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("0302 224 085"),
                                        const Text("0302 233 722")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400]!,
                                          blurRadius: 3.0,
                                          spreadRadius: 1)
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.gradient2,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  size: 27,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Address:",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                                "No 28 Orgle Road North"),
                                            const Text("Kaneshie Accra Ghana")
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.gradient2,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.email_outlined,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Email:",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text("fboachie@yahoo.com"),
                                            const Text("")
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.gradient2,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.phone_outlined,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Phone:",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text("0302 224 085"),
                                            const Text("0302 233 722")
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Kumasi Branch",
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsMedium,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Visibility(
                              visible: MediaQuery.of(context).size.width >= 800
                                  ? true
                                  : false,
                              replacement: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[400]!,
                                        blurRadius: 3.0,
                                        spreadRadius: 1)
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: AppColors.gradient2,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              size: 27,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Address:",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsMedium),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("P.O Box Kw 228, Kwadaso"),
                                        const Text(
                                            "Off Ohwimasi-Denkyemuoso Road")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: AppColors.gradient2,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.email_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Email:",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsMedium),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("frankatsonksi@yahoo.com"),
                                        const Text("")
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: AppColors.gradient2,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.phone_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Phone:",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsMedium),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("0322 051 952"),
                                        const Text("")
                                      ],
                                    ),
                                    const SizedBox(height: 5)
                                  ],
                                ),
                              ),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[400]!,
                                          blurRadius: 3.0,
                                          spreadRadius: 1)
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.gradient2,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  size: 27,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Address:",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                                "P.O Box Kw 228, Kwadaso"),
                                            const Text(
                                                "Off Ohwimasi-Denkyemuoso Road")
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.gradient2,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.email_outlined,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Email:",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                                "frankatsonksi@yahoo.com"),
                                            const Text("")
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.gradient2,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.phone_outlined,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Phone:",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text("0322 051 952"),
                                            const Text("")
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      const Footer()
                    ],
                  ),
                ),
                Visibility(
                    visible: viewModel.showScrollUp,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 20),
                        child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            elevation: 5,
                            child: InkWell(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: AppColors.gradient1),
                                child: const Center(
                                  child: Icon(
                                    Icons.keyboard_double_arrow_up,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              onTap: () {
                                viewModel.moveUp();
                              },
                            )),
                      ),
                    ))
              ],
            )));
  }

  @override
  BigScreenViewModel viewModelBuilder(BuildContext context) =>
      BigScreenViewModel();
}
