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

  Future save(User user) async {
    localStorage['id'] = user.id.toString();
    localStorage['name'] = user.name!;
    localStorage['email'] = user.email!;
    localStorage['location'] = user.location!;
    localStorage['role'] = user.role ?? '';
    localStorage['role_id'] = user.roleId?.toString() ?? '';
    localStorage['image'] = user.image ?? '';
    localStorage['token'] = user.token!;
    localStorage['permissions'] = jsonEncode(user.permissions ?? []);
  }

  Future<Map<String, String>> getUser() async {
    if (localStorage.isEmpty) {
      return {};
    } else {
      return {
        "id": localStorage['id']!,
        "name": localStorage['name']!,
        "email": localStorage['email']!,
        "location": localStorage['location']!,
        "role": localStorage['role']!,
        "role_id": localStorage['role_id']!,
        "image": localStorage['image']!,
        "token": localStorage['token']!,
        "permissions": localStorage['permissions']!,
      };
    }
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
