import 'package:frankoweb/api/base_api.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/models/api_response.dart';

class PostsApi extends BaseApi {
  Future<ApiResponse> createPost(dynamic params) async {
    var response = await post(url: Api.posts, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> addPictureToGallery(dynamic params) async {
    var response = await post(url: Api.gallery, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getGallery() async {
    var response = await get(url: Api.gallery);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getPosts() async {
    var response = await get(url: Api.posts);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> deletePost(String id) async {
    var response = await delete(url: "${Api.deletePost}/$id");
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> deleteGallery(String id) async {
    var response = await delete(url: "${Api.deleteGallery}/$id");
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getBlogCategory() async {
    var response = await get(url: Api.blogCategories);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> createBlogCategory(dynamic params) async {
    var response = await post(url: Api.blogCategories, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> uploadDocument(dynamic params) async {
    var response = await post(url: Api.document, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getDocument() async {
    var response = await get(url: Api.document);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getPostComments(String postId, {int page = 1}) async {
    var response = await get(url: "${Api.posts}/$postId/comments?page=$page");
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> addComment(String postId, dynamic params) async {
    var response = await post(url: "${Api.posts}/$postId/comments", data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> deleteComment(String postId, String commentId) async {
    var response =
        await delete(url: "${Api.posts}/$postId/comments/$commentId");
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> likePost(String postId, dynamic params) async {
    var response = await post(url: "${Api.posts}/$postId/like", data: params);
    return ApiResponse.parse(response);
  }
}
