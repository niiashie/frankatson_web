import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/gallery/gallery_view_model.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:stacked/stacked.dart';

class GalleryScreenView extends StackedView<GalleryViewModel> {
  const GalleryScreenView({
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(GalleryViewModel viewModel) async {
    viewModel.getPics();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
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
                                  "Gallery",
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
                                if (value == "Account") {
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
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                        child: Visibility(
                      visible: !viewModel.showAddGallery,
                      replacement: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 6,
                          ),
                          Material(
                            elevation: 2,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  AppImages.logo,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Select image to upload to gallery",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 400,
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      viewModel.file != null
                                          ? Container(
                                              width: double.infinity,
                                              height: 150,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  15)),
                                                      child: Image.memory(
                                                        Uint8List.fromList(
                                                            viewModel
                                                                .bytesData!),
                                                        width: double.infinity,
                                                        height: 130,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )),
                                                  Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          viewModel
                                                              .clearSelectedImage();
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: AppColors
                                                                      .gradient2),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.clear,
                                                              size: 15,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                ],
                                              ))
                                          : const SizedBox(),
                                      viewModel.selectedFile != null
                                          ? const SizedBox(
                                              height: 15,
                                            )
                                          : const SizedBox(),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CustomButton(
                                            color: AppColors.gradient1,
                                            height: 40,
                                            width: 140,
                                            elevation: 2,
                                            ontap: () {
                                              viewModel.pickFile();
                                            },
                                            title: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Select Image",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                CustomButton(
                                  width: double.infinity,
                                  maxWidth: double.infinity,
                                  height: 45,
                                  isLoading: viewModel.addGalleryLoading,
                                  color: AppColors.gradient2,
                                  title: const Text(
                                    "Add Picture",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  elevation: 2,
                                  ontap: () {
                                    viewModel.addGallery();
                                  },
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Back To Gallery",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            onTap: () {
                              viewModel.backToGallery();
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Visibility(
                              visible: viewModel.getPicsLoading,
                              replacement: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.center,
                                  children: viewModel.items,
                                ),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                height: 400,
                                child: const Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: AppColors.gradient2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Loading",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    )),
                  ),
                )
              ],
            )),
        floatingActionButton: FutureBuilder(
            future: locator<AppService>().getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const SizedBox();
                } else if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty &&
                          snapshot.data!['role'] == "staff"
                      ? Visibility(
                          visible: !viewModel.showAddGallery,
                          child: FloatingActionButton.extended(
                              backgroundColor: AppColors.gradient2,
                              onPressed: () {
                                viewModel.displayAddGallery();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: const Text("Add Gallery")),
                        )
                      : const SizedBox();
                }
              }
              return SizedBox(
                width: 25,
                height: 25,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }

  @override
  GalleryViewModel viewModelBuilder(BuildContext context) => GalleryViewModel();
}
