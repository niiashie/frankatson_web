import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frankoweb/api/base_api.dart';

import '../constants/api.dart';
import '../models/api_response.dart';

class AuthApi extends BaseApi {
  Future<ApiResponse> login(Map<String, dynamic> params) async {
    var response = await post(url: Api.login, data: params);
    return ApiResponse.parse(response);
  }

  Future<ApiResponse> register(Map<String, dynamic> params) async {
    var response = await post(url: Api.register, data: params);
    return ApiResponse.parse(response);
  }

  /// Revokes the token currently held by this browser.
  Future<ApiResponse> logout() async {
    var response = await post(url: Api.logout);
    return ApiResponse.parse(response);
  }

  /// Revokes every token issued to the signed-in user.
  Future<ApiResponse> logoutAll() async {
    var response = await post(url: Api.logoutAll);
    return ApiResponse.parse(response);
  }

  /// Current profile and permissions, read fresh from the server.
  ///
  /// Returns 401 when the token has expired or been revoked, which the
  /// interceptor in [BaseApi] turns into a cleared session.
  Future<ApiResponse> me() async {
    var response = await get(url: Api.me);
    return ApiResponse.parse(response);
  }

  /// The signed-in user for this page load, verified against the server once
  /// and then shared by every caller. Returns `{}` when nobody is signed in.
  Future<Map<String, String>> session() {
    return appService!.sessionFuture ??= _loadSession();
  }

  Future<Map<String, String>> _loadSession() async {
    final service = appService!;
    if (!service.isLoggedIn) return {};

    try {
      final response = await me();
      debugPrint("[/auth/me] status=${response.code}");
      debugPrint("[/auth/me] body=${response.body}");

      // Hand saveProfile the whole body: `/auth/me` puts the profile under
      // `user` (not the usual `data` envelope) and may carry `permissions`
      // alongside it rather than nested under the role.
      if (response.ok && response.body is Map) {
        service.saveProfile(Map<String, dynamic>.from(response.body as Map));
      } else {
        debugPrint("[/auth/me] not applied — ok=${response.ok} "
            "bodyType=${response.body.runtimeType}");
      }
    } on DioException catch (e) {
      // A 401 has already been cleared by the interceptor in BaseApi. Anything
      // else — offline, 500 — leaves the cached profile in place rather than
      // signing the user out over a transient failure.
      debugPrint("[/auth/me] FAILED status=${e.response?.statusCode} "
          "type=${e.type}");
      debugPrint("[/auth/me] error body=${e.response?.data}");
    }

    final session = await service.getUser();
    debugPrint("[/auth/me] resulting session: "
        "loggedIn=${service.isLoggedIn} "
        "role='${session['role']}' "
        "permissions=${session['permissions']}");
    return session;
  }

  /// Revokes the token server-side, then clears it locally. The local clear
  /// runs even if the request fails, so the user is never stuck signed in.
  Future<void> signOut() async {
    try {
      await logout();
    } on DioException catch (_) {
      // Already-expired or revoked token — nothing left to revoke.
    } finally {
      appService!.clearSession();
    }
  }
}
