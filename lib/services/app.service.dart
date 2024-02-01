import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/dialog.service.dart' as dialog;

class AppService {
  // User? user;
  // FToast fToast = FToast();
  StreamController<String> momoPaymentListener =
      StreamController<String>.broadcast();

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

  showErrorMessage(
      {String? message = "", String? title = "", double? height = 120}) {
    dialog.DialogService().show(
        title: title,
        type: "error",
        message: message,
        height: height,
        showCancelBtn: false,
        okayBtnText: "Okay",
        onOkayTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
        });
  }

  showSuccessMessage(
      {String? message = "", String? title = "", double? height = 120}) {
    dialog.DialogService().show(
        title: title,
        message: message,
        height: height,
        showCancelBtn: false,
        okayBtnText: "Okay",
        onOkayTap: () {
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
        });
  }

  showWarningMessage(
      {String? message = "",
      String? title = "",
      double? height = 120,
      VoidCallback? okayTap,
      VoidCallback? cancelTap}) {
    dialog.DialogService().show(
        title: title,
        message: message,
        type: "warning",
        okayBtnText: "Yes",
        cancelBtnText: "No",
        onOkayTap: okayTap,
        onCancelTap: cancelTap,
        height: height);
  }
}
