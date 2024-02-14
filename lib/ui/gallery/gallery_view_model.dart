import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

class GalleryViewModel extends BaseViewModel {
  bool showAddGallery = false, addGalleryLoading = false;
  html.File? file;
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  Uint8List? bytesData;
  List<int>? selectedFile;

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

  addGallery() {
    debugPrint("Adding image to gallery");
  }
}
