import 'dart:async';
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
    localStorage['name'] = user.name!;
    localStorage['location'] = user.location!;
    localStorage['id'] = user.id.toString();
    localStorage['role'] = user.role!;
    localStorage['email'] = user.email!;
    localStorage['token'] = user.token!;
  }

  Future<Map<String, String>> getUser() async {
    if (localStorage.isEmpty) {
      return {};
    } else {
      // user = User(
      //     id: int.parse(localStorage['id']!),
      //     name: localStorage['name']!,
      //     location: localStorage['location']!,
      //     role: localStorage['role']!,
      //     email: localStorage['email']!,
      //     token: localStorage['token']!);
      return {
        "name": localStorage['name']!,
        "location": localStorage['location']!,
        "id": localStorage['id']!,
        "role": localStorage['role']!,
        "email": localStorage['email']!,
        "token": localStorage['token']!
      };
    }
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
