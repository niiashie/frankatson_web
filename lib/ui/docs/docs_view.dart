import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/blog/blog_view_model.dart';
import 'package:frankoweb/ui/docs/docs_view_model.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:frankoweb/ui/shared/custom_form_field.dart';

import 'package:stacked/stacked.dart';

class DocumentScreenView extends StackedView<DocViewModel> {
  const DocumentScreenView({
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(DocViewModel viewModel) async {
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
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
                                "Documents",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppFonts.poppinsMedium,
                                    fontSize:
                                        MediaQuery.of(context).size.width >= 800
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
                              } else if (value == "news") {}
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
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                child: Visibility(
                  visible: viewModel.showAddDocument,
                  replacement: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Visibility(
                        visible: viewModel.getDocumentLoading,
                        replacement: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Document List",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ListView.builder(
                                  itemCount: viewModel.docList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: Center(
                                        child: Material(
                                          elevation: 1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width >=
                                                    800
                                                ? 500
                                                : 350,
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width >=
                                                          800
                                                      ? 50
                                                      : 35,
                                                  height: MediaQuery.of(context)
                                                              .size
                                                              .width >=
                                                          800
                                                      ? 50
                                                      : 35,
                                                  color: viewModel.getFileExtension(
                                                              viewModel.docList[
                                                                      index]
                                                                  ['file']) ==
                                                          "pptx"
                                                      ? Colors.orange
                                                      : viewModel.getFileExtension(
                                                                  viewModel.docList[
                                                                          index]
                                                                      [
                                                                      'file']) ==
                                                              "pdf"
                                                          ? Colors.red
                                                          : Colors.blueAccent,
                                                  child: Center(
                                                    child: Text(
                                                      viewModel
                                                          .getFileExtension(
                                                              viewModel.docList[
                                                                      index]
                                                                  ['file']),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: AppFonts
                                                              .poppinsMedium),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width >=
                                                          800
                                                      ? 15
                                                      : 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        viewModel.docList[index]
                                                            ['title'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: AppFonts
                                                                .poppinsMedium,
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >=
                                                                    800
                                                                ? 17
                                                                : 14),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "posted by  ",
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width >=
                                                                        800
                                                                    ? 10
                                                                    : 7,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Text(
                                                            viewModel.docList[
                                                                        index]
                                                                    ['user']
                                                                ['name'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width >=
                                                                        800
                                                                    ? 17
                                                                    : 14),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  height: 60,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: CustomButton(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width >=
                                                                  800
                                                              ? 100
                                                              : 80,
                                                      height:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width >=
                                                                  800
                                                              ? 35
                                                              : 30,
                                                      color:
                                                          AppColors.gradient2,
                                                      title: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "Download",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width >=
                                                                        800
                                                                    ? 10
                                                                    : 8),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_downward,
                                                            color: Colors.white,
                                                            size: 8,
                                                          )
                                                        ],
                                                      ),
                                                      ontap: () {
                                                        viewModel.viewFileInNewTab(
                                                            "${Api.dataUrl}${viewModel.docList[index]['file']}",
                                                            viewModel.docList[
                                                                    index]
                                                                ['title']);
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.gradient1,
                                  strokeWidth: 1,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Loading ..",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        )),
                  ),
                  child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                            "Fill in the details required to add news",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                              width: 400,
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15, right: 15),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Form(
                                key: viewModel.docKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomFormField(
                                      hintText: "Enter document name",
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
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  viewModel.filename,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),
                                          ),
                                          CustomButton(
                                            width: 120,
                                            height: 40,
                                            color: AppColors.gradient1,
                                            title: const Text(
                                              "Choose File",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            ontap: () {
                                              viewModel.pickFile();
                                            },
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomButton(
                                      width: double.infinity,
                                      maxWidth: double.infinity,
                                      height: 50,
                                      color: AppColors.gradient2,
                                      title: const Text(
                                        "Upload Document",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      isLoading:
                                          viewModel.uploadDocumentLoading,
                                      ontap: () {
                                        viewModel.uploadFile();
                                      },
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
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
                          visible: !viewModel.showAddDocument,
                          child: FloatingActionButton.extended(
                              backgroundColor: AppColors.gradient2,
                              onPressed: () {
                                viewModel.viewAddDocument();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: const Text("Add Document")),
                        )
                      : const SizedBox();
                }
              }
              return const SizedBox(
                width: 25,
                height: 25,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }

  @override
  DocViewModel viewModelBuilder(BuildContext context) => DocViewModel();
}
