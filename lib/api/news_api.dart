import 'package:frankoweb/api/base_api.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/models/api_response.dart';

class NewsApi extends BaseApi {
  Future<ApiResponse> createNews(dynamic params) async {
    var response = await post(url: Api.news, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> getNews() async {
    var response = await get(url: Api.news);
    return ApiResponse.parse(response);
  }
}
