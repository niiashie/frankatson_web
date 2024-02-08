import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:stacked/stacked.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class NewsViewModel extends BaseViewModel {
  bool showManagesNews = false, showAddNews = false, createNewsLoading = false;
  TextEditingController? title, content, description;
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  final GlobalKey<FormState> newsKey = GlobalKey<FormState>();
  var appService = locator<AppService>();
  List<int>? selectedFile;
  html.File? file;
  Uint8List? bytesData;

  NewsApi newsApi = NewsApi();

  init() {
    title = TextEditingController(text: "");
    content = TextEditingController(text: "");
    description = TextEditingController(text: "");
  }

  displayManageNews() {
    showManagesNews = true;
    rebuildUi();
  }

  createNews() async {
    if (newsKey.currentState!.validate()) {
      if (file != null) {
        FormData data = FormData.fromMap({
          "title": title!.text,
          "content": content!.text,
          "description": description!.text,
          "author_id": appService.user!.id,
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
            rebuildUi();
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
