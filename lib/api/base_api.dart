// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/constants/routes.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/locator.dart';
import '../constants/api.dart';

class BaseApi {
  AppService? appService = locator<AppService>();
  final Storage localStorage = window.localStorage;

  /// Guards against several in-flight requests all 401-ing at once and each
  /// trying to bounce the user to the account screen.
  static bool _handlingExpiry = false;

  Dio _getDio() {
    final token = localStorage['token'] ?? '';
    Dio dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(seconds: Api.connectionTimeout),
        receiveTimeout: const Duration(seconds: Api.receiveTimeout),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) _onUnauthenticated(e);
          return handler.next(e);
        },
      ),
    );

    return dio;
  }

  /// The token is gone, expired, or revoked. Tear the session down locally so
  /// the UI stops presenting the user as signed in.
  ///
  /// A 401 from the auth endpoints themselves is ignored: logging out with a
  /// dead token, or a failed `/auth/me`, should not bounce the user mid-flow.
  /// (Bad credentials come back as 400, so login never lands here.)
  void _onUnauthenticated(DioException e) {
    final path = e.requestOptions.path;
    debugPrint("[401] $path — clearing session. body=${e.response?.data}");

    if (path.startsWith(Api.auth)) {
      locator<AppService>().clearSession();
      return;
    }

    if (_handlingExpiry) return;
    _handlingExpiry = true;

    locator<AppService>().clearSession();

    final context = StackedService.navigatorKey?.currentContext;
    if (context != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(Routes.accountScreen);
        _handlingExpiry = false;
      });
    } else {
      _handlingExpiry = false;
    }
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
