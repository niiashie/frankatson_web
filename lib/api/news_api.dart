import 'package:frankoweb/api/base_api.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/models/api_response.dart';

class NewsApi extends BaseApi {
  Future<ApiResponse> createNews(dynamic params) async {
    var response = await post(url: Api.news, data: params);
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

  Future<ApiResponse> getNews() async {
    var response = await get(url: Api.news);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> deleteNews(String id) async {
    var response = await delete(url: "${Api.deleteNews}/$id");
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
}
