import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/models/blog_category.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/blog/widgets/blog_category_item.dart';
import 'package:frankoweb/ui/blog/widgets/blog_info.dart';
import 'package:stacked/stacked.dart';
import 'dart:html' as html;

import 'package:stacked_services/stacked_services.dart';

class BlogViewModel extends BaseViewModel {
  bool showBlogs = false,
      blogCategoryLoading = false,
      showAddBlogCategory = false,
      addBlogCategoryLoading = false;
  NewsApi newsApi = NewsApi();
  List<BlogCategoryItem> items = [];
  var appService = locator<AppService>();
  TextEditingController? name, description;
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  html.File? file;
  List<int>? selectedFile;
  final GlobalKey<FormState> blogKey = GlobalKey<FormState>();
  Uint8List? bytesData;

  init() {
    name = TextEditingController(text: "");
    description = TextEditingController(text: "");
    getBlockCategory();
  }

  displayAddBlogCategory() {
    showAddBlogCategory = true;
    rebuildUi();
  }

  clearSelectedImage() {
    file = null;
    rebuildUi();
  }

  backToNews() {
    showAddBlogCategory = false;
    rebuildUi();
  }

  createBlogCategory() async {
    if (blogKey.currentState!.validate()) {
      if (file != null) {
        FormData data = FormData.fromMap({
          "name": name!.text,
          "description": description!.text,
          "cover_img": MultipartFile.fromBytes(selectedFile!, filename: "cv")
        });

        try {
          addBlogCategoryLoading = true;
          rebuildUi();

          ApiResponse createNewsResponse =
              await newsApi.createBlogCategory(data);
          if (createNewsResponse.ok) {
            debugPrint("response: ${createNewsResponse.body}");
            appService.showErrorFromApiRequest(
                title: "News Upload", message: "Successfully uploaded news");
            addBlogCategoryLoading = false;
            showAddBlogCategory = false;
            reset();
            getBlockCategory();
          }
        } on DioException catch (e) {
          addBlogCategoryLoading = false;
          rebuildUi();
          ApiResponse errorResponse = ApiResponse.parse(e.response);
          debugPrint(errorResponse.message);
          appService.showErrorFromApiRequest(message: errorResponse.message!);
        }
      } else {
        appService.showErrorFromApiRequest(
            title: "Cover Image",
            message: "Please select cover image to proceed");
      }
    }
  }

  reset() {
    file = null;
    name!.text = "";
    description!.text = "";
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

          rebuildUi();
        });
        reader.readAsDataUrl(file!);
      }
    });
  }

  getBlockCategory() async {
    try {
      blogCategoryLoading = true;
      items.clear();

      rebuildUi();

      var response = await newsApi.getBlogCategory();
      if (response.ok) {
        List<dynamic> newsData = response.body;
        for (var obj in newsData) {
          items.add(BlogCategoryItem(
            blogCategoryItem: BlogCategory.fromJson(obj),
            viewBlog: (a) {
              Navigator.of(StackedService.navigatorKey!.currentContext!).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return BlogInfoScreen(
                      category: a,
                    );
                  },
                ),
              );
            },
          ));
        }
      }
      blogCategoryLoading = false;
      rebuildUi();
    } on DioException catch (e) {
      blogCategoryLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }
}
