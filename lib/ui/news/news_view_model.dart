import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/models/news.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/news/widget/news_item.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:typed_data';
import '../../../services/dialog.service.dart' as dialog;
import 'dart:html' as html;

class NewsViewModel extends BaseViewModel {
  bool showManagesNews = false,
      showAddNews = false,
      createNewsLoading = false,
      getNewsLoading = false;
  TextEditingController? title, content, description;
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  final GlobalKey<FormState> newsKey = GlobalKey<FormState>();
  var appService = locator<AppService>();
  List<int>? selectedFile;
  html.File? file;
  Uint8List? bytesData;
  List<Map<String, dynamic>> newsList = [];
  List<NewsItem> newsItems = [];

  NewsApi newsApi = NewsApi();

  init() {
    title = TextEditingController(text: "");
    content = TextEditingController(text: "");
    description = TextEditingController(text: "");
    getNews();
  }

  displayManageNews() {
    showManagesNews = true;
    rebuildUi();
  }

  backToNews() {
    showManagesNews = false;
    showAddNews = false;
    rebuildUi();
  }

  getNews() async {
    try {
      getNewsLoading = true;
      newsList.clear();
      newsItems.clear();
      rebuildUi();

      var response = await newsApi.getNews();
      if (response.ok) {
        List<dynamic> newsData = response.data;
        for (var obj in newsData) {
          newsItems.add(NewsItem(newsItem: News.fromJson(obj)));
          newsList.add({"news": News.fromJson(obj), "loading": false});
        }
      }
      getNewsLoading = false;
      rebuildUi();
    } on DioException catch (e) {
      getNewsLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  deleteNews(int index) {
    dialog.DialogService().show(
        title: "Delete News",
        message: "Do you really want to delete news",
        okayBtnText: "Yes",
        cancelBtnText: "No",
        onOkayTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
          deleteNewsRequest(index);
        },
        onCancelTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
        });
  }

  deleteNewsRequest(int index) async {
    Map<String, dynamic> selectedNewsObject = newsList[index];
    try {
      selectedNewsObject['loading'] = true;
      rebuildUi();
      ApiResponse deleteNewsResponse =
          await newsApi.deleteNews(selectedNewsObject['news'].id.toString());
      if (deleteNewsResponse.ok) {
        newsList.removeAt(index);
        rebuildUi();
      }
      if (deleteNewsResponse.ok) {}
    } on DioException catch (e) {
      selectedNewsObject['loading'] = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  createNews() async {
    if (newsKey.currentState!.validate()) {
      if (file != null) {
        FormData data = FormData.fromMap({
          "title": title!.text,
          "content": content!.text,
          "description": description!.text,
          "author_id": appService.localStorage['id'],
          "cover_img": MultipartFile.fromBytes(selectedFile!, filename: "cv")
        });

        try {
          createNewsLoading = true;
          rebuildUi();

          ApiResponse createNewsResponse = await newsApi.createNews(data);
          if (createNewsResponse.ok) {
            debugPrint("response: ${createNewsResponse.body}");
            appService.showErrorFromApiRequest(
                title: "News Upload", message: "Successfully uploaded news");
            createNewsLoading = false;
            reset();
            getNews();
          }
        } on DioException catch (e) {
          createNewsLoading = false;
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
    title!.text = "";
    content!.text = "";
    description!.text = "";
    file = null;
  }

  clearSelectedImage() {
    file = null;
    rebuildUi();
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

  displayAddNews() {
    showAddNews = true;
    rebuildUi();
  }
}
