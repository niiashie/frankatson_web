import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frankoweb/models/user.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/dialog.service.dart' as dialog;

class AppService {
  User? user;
  // FToast fToast = FToast();
  StreamController<String> momoPaymentListener =
      StreamController<String>.broadcast();
  final Storage localStorage = window.localStorage;

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("This is a Custom Toast"),
      ],
    ),
  );

  /// Writes the profile half of a session from a server payload, leaving the
  /// token alone. Used to refresh name/role/permissions from `/auth/me` so the
  /// UI stops relying on whatever was cached at login time.
  ///
  /// Takes the whole response body, because `/auth/me` and `/auth/login` do
  /// not shape it identically: the role may be a nested object or a bare name,
  /// and permissions may sit under the role or at the top level. A field the
  /// payload does not mention is left untouched rather than blanked — blanking
  /// a role here silently strips the user of every gated view.
  void saveProfile(Map<String, dynamic> body) {
    final user = body['user'] is Map
        ? Map<String, dynamic>.from(body['user'] as Map)
        : body;
    final role = user['role'];

    void put(String key, Object? value) {
      if (value == null) return;
      localStorage[key] = value.toString();
    }

    put('id', user['id']);
    put('name', user['name']);
    put('email', user['email']);
    put('location', user['location']);
    put('role_id', user['role_id']);
    put('image', user['image']);
    put('role', role is Map ? role['name'] : role);

    final permissions =
        (role is Map ? role['permissions'] : null) ?? body['permissions'];
    if (permissions is List) {
      localStorage['permissions'] = jsonEncode(permissions);
    }
    sessionRevision.value++;
  }

  /// Persists a signed-in user.
  ///
  /// Every field is written null-safely: a half-written session (profile
  /// stored, token missing) reads as signed-out everywhere and is far harder
  /// to diagnose than an outright failure. [AccountViewModel] rejects a
  /// tokenless response before it ever reaches here.
  Future save(User user) async {
    localStorage['id'] = user.id?.toString() ?? '';
    localStorage['name'] = user.name ?? '';
    localStorage['email'] = user.email ?? '';
    localStorage['location'] = user.location ?? '';
    localStorage['role'] = user.role ?? '';
    localStorage['role_id'] = user.roleId?.toString() ?? '';
    localStorage['image'] = user.image ?? '';
    localStorage['token'] = user.token ?? '';
    localStorage['permissions'] = jsonEncode(user.permissions ?? []);

    // Seed the cache from what we just stored instead of clearing it. The
    // login response already carries the full profile, so re-asking `/auth/me`
    // would only add a round trip the UI has to wait on — and a failure there
    // would tear down the session that just succeeded.
    sessionFuture = getUser();
    sessionRevision.value++;
  }

  /// Bumped whenever the stored session changes — login, refresh or logout.
  /// Widgets that render the signed-in user listen to this so they re-read
  /// instead of holding whatever they saw when they were first built.
  final ValueNotifier<int> sessionRevision = ValueNotifier<int>(0);

  /// Cached one-shot session refresh for this page load.
  ///
  /// Held here (rather than in the API layer) so every widget that needs the
  /// signed-in user shares a single `/auth/me` round trip. Reset by
  /// [clearSession] so a logout and a subsequent login re-fetch.
  Future<Map<String, String>>? sessionFuture;

  /// Whether this browser holds a token. Says nothing about whether the token
  /// is still valid — only the server can answer that, via `/auth/me`.
  bool get isLoggedIn => (localStorage['token'] ?? '').isNotEmpty;

  Future<Map<String, String>> getUser() async {
    // Key off the token, not [Storage.isEmpty]: anything else writing a single
    // unrelated key would otherwise make an empty session look populated.
    if (!isLoggedIn) return {};
    return {
      "id": localStorage['id'] ?? '',
      "name": localStorage['name'] ?? '',
      "email": localStorage['email'] ?? '',
      "location": localStorage['location'] ?? '',
      "role": localStorage['role'] ?? '',
      "role_id": localStorage['role_id'] ?? '',
      "image": localStorage['image'] ?? '',
      "token": localStorage['token'] ?? '',
      "permissions": localStorage['permissions'] ?? '[]',
    };
  }

  /// Drops every trace of the session from this browser.
  ///
  /// Removes only the keys we own rather than calling `localStorage.clear()`,
  /// which would also wipe unrelated keys belonging to the page.
  void clearSession() {
    for (final key in const [
      'id',
      'name',
      'email',
      'location',
      'role',
      'role_id',
      'image',
      'token',
      'permissions',
      'expires_at',
    ]) {
      localStorage.remove(key);
    }
    user = null;
    sessionFuture = null;
    sessionRevision.value++;
  }

  List<String> getPermissions() {
    final raw = localStorage['permissions'];
    if (raw == null || raw.isEmpty) return [];
    return List<String>.from(jsonDecode(raw));
  }

  bool hasPermission(String permission) {
    return getPermissions().contains(permission);
  }

  showErrorFromApiRequest({String? message, String? title = "Whoops!!!"}) {
    dialog.DialogService().show(
        title: title,
        message: message,
        showCancelBtn: false,
        okayBtnText: "Okay",
        onOkayTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
        });
  }
}
