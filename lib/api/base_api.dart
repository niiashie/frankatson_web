// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:frankoweb/services/app.service.dart';
import '../app/locator.dart';
import '../constants/api.dart';

class BaseApi {
  AppService? appService = locator<AppService>();
  final Storage localStorage = window.localStorage;
  Dio _getDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(seconds: Api.connectionTimeout),
        receiveTimeout: const Duration(seconds: Api.receiveTimeout),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${localStorage['token'] ?? ''}'
        },
      ),
    );

    return dio;
  }

  Future get({required String url, dynamic queryParameters}) {
    return _getDio().get(url, queryParameters: queryParameters);
  }

  Future post({required String url, dynamic data}) {
    return _getDio().post(url, data: data);
  }

  Future delete({required String url, dynamic queryParameters}) {
    return _getDio().delete(url, queryParameters: queryParameters);
  }

  Future patch({required String url, dynamic data}) {
    return _getDio().patch(url, data: data);
  }
}
