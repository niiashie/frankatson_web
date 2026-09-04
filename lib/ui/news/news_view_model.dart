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

  // Cover media (image or video) metadata for the create-post form.
  String? coverFileName;
  String? coverMimeType;
  int coverFileSize = 0;
  bool coverIsVideo = false;
  bool coverLoading = false;
  // blob: URL for the picked file, used to play a video preview before upload.
  String? coverObjectUrl;

  /// API hard limit for `cover_img` (image or video).
  static const int maxCoverBytes = 100 * 1024 * 1024; // 100 MB
  /// Above this a video is so far over the limit that compressing it down to
  /// 100 MB would badly degrade quality — we reject it instead.
  static const int videoReencodeAdviseBytes = 250 * 1024 * 1024; // 250 MB

  String get coverSizeLabel =>
      coverFileSize > 0 ? _formatSize(coverFileSize) : "";

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
      if (file == null) {
        appService.showErrorFromApiRequest(
            title: "Cover Media",
            message: "Please select a cover image or video to proceed");
        return;
      }
      if (selectedFile == null) {
        appService.showErrorFromApiRequest(
            title: "Cover Media",
            message: coverLoading
                ? "The selected file is still loading, please wait a moment."
                : "Please re-select the cover image or video.");
        return;
      }
      final safeName = (coverFileName != null && coverFileName!.contains('.'))
          ? coverFileName!
          : "cover.${_extensionForMime(coverMimeType) ?? (coverIsVideo ? 'mp4' : 'jpg')}";
      FormData data = FormData.fromMap({
        "title": title!.text,
        "content": content!.text,
        "description": description!.text,
        "cover_img": MultipartFile.fromBytes(selectedFile!, filename: safeName)
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
    }
  }

  reset() {
    title!.text = "";
    content!.text = "";
    description!.text = "";
    _clearCover();
  }

  clearSelectedImage() {
    _clearCover();
    rebuildUi();
  }

  void _clearCover() {
    file = null;
    selectedFile = null;
    bytesData = null;
    coverFileName = null;
    coverMimeType = null;
    coverFileSize = 0;
    coverIsVideo = false;
    coverLoading = false;
    if (coverObjectUrl != null) {
      html.Url.revokeObjectUrl(coverObjectUrl!);
      coverObjectUrl = null;
    }
  }

  pickFile() {
    // MIME wildcards cover the common cases; the explicit extensions make
    // sure containers the browser doesn't map to a MIME type (e.g. .mkv,
    // .mov, .avi) are still selectable in the OS file dialog.
    uploadInput = html.FileUploadInputElement()
      ..accept = 'image/*,video/*,'
          '.jpg,.jpeg,.png,.webp,.gif,.bmp,'
          '.mp4,.m4v,.mov,.webm,.mkv,.avi,.3gp,.mpeg,.mpg,.ogv';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) return;

      final picked = files.first;
      final int size = picked.size;
      // Some browsers leave File.type blank for .mov/.mkv etc — fall back to
      // the file extension.
      String type = picked.type;
      if (type.isEmpty) type = _mimeFromName(picked.name) ?? '';
      final bool isVideo = type.startsWith('video/');
      final bool isImage = type.startsWith('image/');

      if (!isVideo && !isImage) {
        appService.showErrorFromApiRequest(
            title: "Unsupported file",
            message: "Please select an image or a video file.");
        return;
      }

      if (size > maxCoverBytes) {
        if (isVideo && size >= videoReencodeAdviseBytes) {
          appService.showErrorFromApiRequest(
              title: "Video too large",
              message:
                  "This video is ${_formatSize(size)} — far above the 100 MB "
                  "limit. Compressing it that much would seriously degrade the "
                  "quality. Please re-export it at a lower resolution or bitrate, "
                  "or trim its length, then upload again.");
        } else if (isVideo) {
          appService.showErrorFromApiRequest(
              title: "Video over 100 MB",
              message:
                  "This video is ${_formatSize(size)}. The limit is 100 MB. "
                  "Please compress or re-export it to just under 100 MB and "
                  "upload again.");
        } else {
          appService.showErrorFromApiRequest(
              title: "Image over 100 MB",
              message:
                  "This image is ${_formatSize(size)}. The limit is 100 MB. "
                  "Please use a smaller file.");
        }
        return;
      }

      file = picked;
      coverFileName = picked.name;
      coverMimeType = type;
      coverFileSize = size;
      coverIsVideo = isVideo;
      coverLoading = true;
      selectedFile = null;
      bytesData = null;
      // Fresh blob: URL so a video can be played back before upload.
      if (coverObjectUrl != null) {
        html.Url.revokeObjectUrl(coverObjectUrl!);
      }
      coverObjectUrl = html.Url.createObjectUrlFromBlob(picked);
      rebuildUi();

      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) {
        final result = reader.result;
        if (result is ByteBuffer) {
          bytesData = result.asUint8List();
        } else if (result is Uint8List) {
          bytesData = result;
        } else if (result is List<int>) {
          bytesData = Uint8List.fromList(result);
        }
        selectedFile = bytesData;
        coverLoading = false;
        rebuildUi();
      });
      reader.onError.listen((event) {
        coverLoading = false;
        appService.showErrorFromApiRequest(
            title: "File error",
            message: "Could not read the selected file. Please try again.");
        rebuildUi();
      });
      reader.readAsArrayBuffer(picked);
    });
  }

  String _formatSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    }
    return "${(bytes / 1024).toStringAsFixed(0)} KB";
  }

  String? _extensionForMime(String? mime) {
    switch (mime) {
      case 'image/jpeg':
        return 'jpg';
      case 'image/png':
        return 'png';
      case 'image/webp':
        return 'webp';
      case 'image/gif':
        return 'gif';
      case 'video/mp4':
        return 'mp4';
      case 'video/quicktime':
        return 'mov';
      case 'video/webm':
        return 'webm';
      case 'video/x-matroska':
        return 'mkv';
      case 'video/x-msvideo':
        return 'avi';
    }
    return null;
  }

  String? _mimeFromName(String name) {
    final ext = name.contains('.') ? name.split('.').last.toLowerCase() : '';
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      case 'bmp':
        return 'image/bmp';
      case 'mp4':
      case 'm4v':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'webm':
        return 'video/webm';
      case 'mkv':
        return 'video/x-matroska';
      case 'avi':
        return 'video/x-msvideo';
      case '3gp':
        return 'video/3gpp';
      case 'mpeg':
      case 'mpg':
        return 'video/mpeg';
      case 'ogv':
        return 'video/ogg';
    }
    return null;
  }
}
