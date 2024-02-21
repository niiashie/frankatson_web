import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/news/news_view_model.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:frankoweb/ui/shared/custom_form_field.dart';
import 'package:stacked/stacked.dart';

class NewsView extends StackedView<NewsViewModel> {
  const NewsView({
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(NewsViewModel viewModel) async {
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
                                  "News",
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
                          visible: viewModel.showManagesNews,
                          replacement: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Visibility(
                                  visible: viewModel.getNewsLoading,
                                  replacement: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Wrap(
                                      spacing: 20,
                                      runSpacing: 20,
                                      alignment: WrapAlignment.center,
                                      children: viewModel.newsItems,
                                    ),
                                  ),
                                  child: const SizedBox(
                                    width: double.infinity,
                                    height: 500,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: AppColors.gradient2,
                                              strokeWidth: 1,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Loading",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          child: Visibility(
                            visible: !viewModel.showAddNews,
                            replacement: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                ),
                                Material(
                                  elevation: 2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
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
                                  "Fill in the details required to add news",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 400,
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Form(
                                      key: viewModel.newsKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomFormField(
                                            hintText: "Enter news title",
                                            label: " Title",
                                            filled: true,
                                            controller: viewModel.title,
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.title_outlined,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Title is required.";
                                              }

                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomFormField(
                                            hintText:
                                                "Enter news brief description",
                                            label: " Brief Description",
                                            filled: true,
                                            controller: viewModel.description,
                                            maxLines: null,
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.description,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Brief description is required.";
                                              }

                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomFormField(
                                            hintText: "Enter news content",
                                            label: " Content",
                                            filled: true,
                                            controller: viewModel.content,
                                            maxLines: null,
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.description,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Content is required.";
                                              }

                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                top: 2, bottom: 2),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                viewModel.file != null
                                                    ? Container(
                                                        width: double.infinity,
                                                        height: 150,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Center(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            15)),
                                                                child: Image
                                                                    .memory(
                                                                  Uint8List.fromList(
                                                                      viewModel
                                                                          .bytesData!),
                                                                  width: double
                                                                      .infinity,
                                                                  height: 130,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            )),
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    viewModel
                                                                        .clearSelectedImage();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: AppColors
                                                                            .gradient2),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
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
                                                      color:
                                                          AppColors.gradient1,
                                                      height: 40,
                                                      width: 140,
                                                      elevation: 2,
                                                      ontap: () {
                                                        viewModel.pickFile();
                                                      },
                                                      title: const Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .camera_alt_outlined,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Select Image",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                            isLoading:
                                                viewModel.createNewsLoading,
                                            color: AppColors.gradient2,
                                            title: const Text(
                                              "Create News",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            elevation: 2,
                                            ontap: () {
                                              viewModel.createNews();
                                            },
                                          )
                                        ],
                                      ),
                                    )),
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
                                        "Back To News",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    viewModel.backToNews();
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height: 50,
                                    child: Stack(
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Uploaded News",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppFonts.poppinsMedium,
                                                color: Colors.grey,
                                                fontSize: 17),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomButton(
                                            width: 100,
                                            height: 40,
                                            borderRadius: 20,
                                            elevation: 2,
                                            color: AppColors.gradient2,
                                            title: const Text(
                                              "Add News",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            ontap: () {
                                              viewModel.displayAddNews();
                                            },
                                          ),
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      AppColors.gradient2,
                                      AppColors.gradient1,
                                    ],
                                  )),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "Image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "Title",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "Description",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "Author",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "Actions",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: !viewModel.getNewsLoading,
                                  replacement: Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height: 30,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.gradient2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.only(
                                        top: 1, bottom: 1),
                                    child: ListView.builder(
                                        itemCount: viewModel.newsList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: double.infinity,
                                            height: 80,
                                            color: index % 2 == 0
                                                ? Colors.white
                                                : Colors.grey[200],
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Image.network(
                                                        "${Api.dataUrl}${viewModel.newsList[index]['news'].image}",
                                                        width: 80,
                                                        height: 60,
                                                        fit: BoxFit.fill,
                                                        frameBuilder: (context,
                                                            child,
                                                            frame,
                                                            wasSynchronouslyLoaded) {
                                                      return child;
                                                    }, loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      } else {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: AppColors
                                                                .gradient1,
                                                            strokeWidth: 1,
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "${viewModel.newsList[index]['news'].title}",
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "${viewModel.newsList[index]['news'].description}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "${viewModel.newsList[index]['news'].user!.name}",
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: viewModel.newsList[
                                                                    index]
                                                                ['loading'] ==
                                                            false
                                                        ? InkWell(
                                                            child: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            onTap: () {
                                                              viewModel
                                                                  .deleteNews(
                                                                      index);
                                                            },
                                                          )
                                                        : SizedBox(
                                                            width: 25,
                                                            height: 25,
                                                            child:
                                                                CircularProgressIndicator(
                                                              strokeWidth: 1,
                                                              color: AppColors
                                                                  .gradient2,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                const SizedBox(height: 20),
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
                                        "Back To News",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    viewModel.backToNews();
                                  },
                                ),
                              ],
                            ),
                          ))),
                ))
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
                          visible: !viewModel.showAddNews,
                          child: FloatingActionButton.extended(
                              backgroundColor: AppColors.gradient2,
                              onPressed: () {
                                viewModel.displayManageNews();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: const Text("Manage News")),
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
  NewsViewModel viewModelBuilder(BuildContext context) => NewsViewModel();
}
