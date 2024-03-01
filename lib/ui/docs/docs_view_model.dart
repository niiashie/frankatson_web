import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:stacked/stacked.dart';
import 'dart:html' as html;

class DocViewModel extends BaseViewModel {
  bool showAddDocument = false, getDocumentLoading = false;
  var appService = locator<AppService>();
  final GlobalKey<FormState> docKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController(text: "");
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  List<dynamic> docList = [];
  html.File? file;
  NewsApi newsApi = NewsApi();
  String filename = "No file selected", postedBy = "";
  List<int>? selectedFile;
  Uint8List? bytesData;
  bool uploadDocumentLoading = false;

  viewAddDocument() {
    showAddDocument = true;
    rebuildUi();
  }

  init() {
    getUser();
    getDocument();
  }

  getUser() async {
    Map<String, dynamic> user = await locator<AppService>().getUser();
    if (user.isNotEmpty) {
      postedBy = user['id'];
    }
  }

  clearSelectedImage() {
    file = null;
    rebuildUi();
  }

  getDocument() async {
    getDocumentLoading = true;
    rebuildUi();
    try {
      ApiResponse docResponse = await newsApi.getDocument();
      if (docResponse.ok) {
        getDocumentLoading = false;
        rebuildUi();
        docList = docResponse.body;
        debugPrint("${docResponse.body}");
      }
    } on DioException catch (e) {
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      getDocumentLoading = false;
      rebuildUi();
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  void viewFileInNewTab(String fileUrl, String fileName) {
    html.window.open(fileUrl, fileName);
  }

  String getFileExtension(String txt) {
    int index = txt.indexOf(".");

    if (index != -1) {
      // Get the substring after the character
      String result = txt.substring(index + 1);
      return result;
    } else {
      return "";
    }
  }

  uploadFile() async {
    if (file == null) {
      appService.showErrorFromApiRequest(
          message: "Please select document to upload", title: "Empty file");
    } else if (docKey.currentState!.validate()) {
      FormData data = FormData.fromMap({
        "title": title.text,
        "posted_by": postedBy,
        "doc_file": MultipartFile.fromBytes(selectedFile!, filename: filename)
      });

      try {
        uploadDocumentLoading = true;
        rebuildUi();
        ApiResponse documentResponse = await newsApi.uploadDocument(data);
        if (documentResponse.ok) {
          appService.showErrorFromApiRequest(
              title: "Document Upload",
              message: "Successfully uploaded document");
          uploadDocumentLoading = false;
          showAddDocument = false;
          reset();
          //getBlockCategory();
        }
      } on DioException catch (e) {
        uploadDocumentLoading = false;
        rebuildUi();
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    }
  }

  reset() {
    file = null;
    title.text = "";
    filename = "No file selected";
    uploadDocumentLoading = false;
    getDocument();
  }

  pickFile() {
    uploadInput = html.FileUploadInputElement()
      ..accept =
          '.pdf,.docx,.pptx'; // Customize the accepted file types if necessary
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      List<html.File> files = uploadInput.files!;
      if (files.length == 1) {
        file = files[0];
        filename = file!.name;
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
}
