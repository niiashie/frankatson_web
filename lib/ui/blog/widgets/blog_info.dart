import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/models/blog_category.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:frankoweb/ui/shared/custom_form_field.dart';
import 'dart:html' as html;

class BlogInfoScreen extends StatefulWidget {
  final BlogCategory category;
  const BlogInfoScreen({super.key, required this.category});

  @override
  State<BlogInfoScreen> createState() => _BlogInfoScreenState();
}

class _BlogInfoScreenState extends State<BlogInfoScreen> {
  bool showAddBlog = false, addBlogLoading = false, getBlogLoading = false;
  TextEditingController? title, content;
  final GlobalKey<FormState> blogDetailKey = GlobalKey<FormState>();
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  html.File? file;
  List<int>? selectedFile;

  Uint8List? bytesData;
  String documentTitle = "Select document in .doc/.pdf/.ppt";

  @override
  void initState() {
    title = TextEditingController(text: "");
    content = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              InkWell(
                                child: Text(
                                  "Blog Category",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppFonts.poppinsMedium,
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
                                "${widget.category.name}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppFonts.poppinsMedium,
                                    fontSize:
                                        MediaQuery.of(context).size.width >= 800
                                            ? 20
                                            : 17),
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
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Visibility(
                        visible: getBlogLoading,
                        replacement: Visibility(
                            visible: showAddBlog,
                            replacement: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  color: Colors.amber,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    width: 450,
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
                                      key: blogDetailKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomFormField(
                                            hintText: "Enter blog title",
                                            label: " Name",
                                            filled: true,
                                            controller: title,
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
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                top: 2, bottom: 2),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                file != null
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
                                                                  Uint8List
                                                                      .fromList(
                                                                          bytesData!),
                                                                  width: 300,
                                                                  height: 200,
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
                                                                    clearSelectedImage();
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
                                                selectedFile != null
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
                                                        pickFile();
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
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15),
                                                          child: Text(
                                                            documentTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child: CustomButton(
                                                              width: 100,
                                                              height: 35,
                                                              color: AppColors
                                                                  .gradient1,
                                                              title: const Text(
                                                                "Choose File",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              ontap: () {
                                                                debugPrint(
                                                                    "Awaiting implementation");
                                                              },
                                                            ),
                                                          ))
                                                    ],
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
                                            isLoading: addBlogLoading,
                                            color: AppColors.gradient2,
                                            title: Text(
                                              "Add Blog To ${widget.category.name} Category",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            elevation: 2,
                                            ontap: () {
                                              //viewModel.createBlogCategory();
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
                                        "Back To Blog",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    backToNews();
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            )),
                        child: const Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: AppColors.gradient2,
                                strokeWidth: 1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Loading")
                          ],
                        ),
                      ),
                    )),
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
                          visible: !showAddBlog,
                          child: FloatingActionButton.extended(
                              backgroundColor: AppColors.gradient2,
                              onPressed: () {
                                displayAddBlog();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: const Text("Add Blog")),
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

  backToNews() {
    showAddBlog = false;
    setState(() {});
  }

  clearSelectedImage() {
    file = null;
    setState(() {});
  }

  displayAddBlog() {
    showAddBlog = true;
    setState(() {});
  }

  pickFile() {
    uploadInput = html.FileUploadInputElement()
      ..accept =
          '.png,.jpg,.jpeg'; // Customize the accepted file types if necessary
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      List<html.File> files = uploadInput.files!;
      if (files.length == 1) {
        file = files[0];
        final reader = html.FileReader();
        reader.onLoadEnd.listen((event) {
          bytesData = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);
          selectedFile = bytesData;

          setState(() {});
        });
        reader.readAsDataUrl(file!);
      }
    });
  }
}
