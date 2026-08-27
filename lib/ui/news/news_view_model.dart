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

class PostsViewModel extends BaseViewModel {
  bool createPostLoading = false, getPostsLoading = false;
  bool isAdmin = false;
  TextEditingController? title, content, description;
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  final GlobalKey<FormState> postKey = GlobalKey<FormState>();
  var appService = locator<AppService>();
  List<int>? selectedFile;
  html.File? file;
  Uint8List? bytesData;
  List<Map<String, dynamic>> postsList = [];
  List<PostItem> postItems = [];
  int totalPosts = 0;

  PostsApi postsApi = PostsApi();
  ScrollController scrollController = ScrollController();
  bool isScrolled = false;

  init() async {
    title = TextEditingController(text: "");
    content = TextEditingController(text: "");
    description = TextEditingController(text: "");
    scrollController.addListener(() {
      isScrolled = scrollController.offset > 80;
      rebuildUi();
    });
    final user = await appService.getUser();
    isAdmin = user.isNotEmpty && user['role'] == "admin";
    rebuildUi();
    getPosts();
  }

  getPosts() async {
    try {
      getPostsLoading = true;
      postsList.clear();
      postItems.clear();
      rebuildUi();

      var response = await postsApi.getPosts();
      if (response.ok) {
        totalPosts = response.totalData ?? 0;
        List<dynamic> postsData = response.data;
        for (var obj in postsData) {
          final post = Post.fromJson(obj);
          postItems.add(PostItem(postItem: post));
          postsList.add({"post": post, "loading": false});
        }
      }
      getPostsLoading = false;
      rebuildUi();
    } on DioException catch (e) {
      getPostsLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  deletePost(int index) {
    dialog.DialogService().show(
        title: "Delete Post",
        message: "Do you really want to delete this post",
        okayBtnText: "Yes",
        cancelBtnText: "No",
        onOkayTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
          deletePostRequest(index);
        },
        onCancelTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
        });
  }

  deletePostRequest(int index) async {
    Map<String, dynamic> selectedPostObject = postsList[index];
    try {
      selectedPostObject['loading'] = true;
      rebuildUi();
      ApiResponse deletePostResponse =
          await postsApi.deletePost(selectedPostObject['post'].id.toString());
      if (deletePostResponse.ok) {
        postsList.removeAt(index);
        rebuildUi();
      }
    } on DioException catch (e) {
      selectedPostObject['loading'] = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  createPost({VoidCallback? onSuccess}) async {
    if (postKey.currentState!.validate()) {
      if (file != null) {
        FormData data = FormData.fromMap({
          "title": title!.text,
          "content": content!.text,
          "description": description!.text,
          "author_id": appService.localStorage['id'],
          "cover_img": MultipartFile.fromBytes(selectedFile!, filename: "cv")
        });

        try {
          createPostLoading = true;
          rebuildUi();

          ApiResponse createPostResponse = await postsApi.createPost(data);
          if (createPostResponse.ok) {
            debugPrint("response: ${createPostResponse.body}");
            appService.showErrorFromApiRequest(
                title: "Post Upload", message: "Successfully uploaded post");
            createPostLoading = false;
            reset();
            getPosts();
            onSuccess?.call();
          }
        } on DioException catch (e) {
          createPostLoading = false;
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
}
