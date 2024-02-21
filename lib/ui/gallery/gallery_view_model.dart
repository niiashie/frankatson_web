import 'dart:convert';
import 'dart:html' as html;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/api/news_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/models/gallery.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:frankoweb/ui/gallery/widget/gallery_item.dart';
import 'package:stacked/stacked.dart';

class GalleryViewModel extends BaseViewModel {
  bool showAddGallery = false,
      addGalleryLoading = false,
      getPicsLoading = false;

  html.File? file;
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  Uint8List? bytesData;
  List<int>? selectedFile;
  var appService = locator<AppService>();
  NewsApi newsApi = NewsApi();
  List<GalleryItem> items = [];
  displayAddGallery() {
    showAddGallery = true;
    rebuildUi();
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

  backToGallery() {
    showAddGallery = false;
    rebuildUi();
  }

  getPics() async {
    try {
      getPicsLoading = true;
      items.clear();
      rebuildUi();

      ApiResponse response = await newsApi.getGallery();
      if (response.ok) {
        List<dynamic> picList = response.data;
        for (var obj in picList) {
          items.add(GalleryItem(
              gallery: Gallery.fromJson(obj),
              onDeleteCompleted: () {
                getPics();
              }));
        }
        getPicsLoading = false;
        rebuildUi();
      }
    } on DioException catch (e) {
      getPicsLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  addGallery() async {
    if (file != null) {
      FormData data = FormData.fromMap({
        "gallery_img": MultipartFile.fromBytes(selectedFile!, filename: "cv")
      });

      try {
        addGalleryLoading = true;
        rebuildUi();

        ApiResponse createNewsResponse =
            await newsApi.addPictureToGallery(data);
        if (createNewsResponse.ok) {
          appService.showErrorFromApiRequest(
              title: "Picture Upload",
              message: "Successfully uploaded picture");
          addGalleryLoading = false;
          file = null;
          getPics();
          rebuildUi();
          backToGallery();
          // reset();
          // getNews();
        }
      } on DioException catch (e) {
        addGalleryLoading = false;
        rebuildUi();
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    } else {
      appService.showErrorFromApiRequest(
          title: "Empty Image", message: "Please select image to proceed");
    }
  }
}
