// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class DialogService {
  Future show(
      {String? message,
      String? title,
      String okayBtnText = "Okay",
      String cancelBtnText = "Cancel",
      VoidCallback? onOkayTap,
      VoidCallback? onCancelTap,
      bool barrierDismissible = true,
      bool autoClose = true,
      double? height = 130,
      bool showCancelBtn = true,
      String? notice,
      double? width = 350,
      String type = "success",
      Widget? customWidget}) {
    return showDialog(
      context: StackedService.navigatorKey!.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        Widget dialog;
        switch (type) {
          case 'success':
            dialog = Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: customWidget,
            );
            // SucessDialog(
            //     okayText: okayBtnText,
            //     cancelText: cancelBtnText,
            //     title: title,
            //     height: height,
            //     message: message,
            //     hasCancel: showCancelBtn,
            //     onCancelTapped: () {
            //       onCancelTap!();
            //     },
            //     onOkayTapped: () {
            //       onOkayTap!();
            //     });
            break;
          case 'error':
            dialog = Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: customWidget,
            );
          //  ErrorDialog(
          //     okayText: okayBtnText,
          //     cancelText: cancelBtnText,
          //     title: title,
          //     height: height,
          //     message: message,
          //     hasCancel: showCancelBtn,
          //     onCancelTapped: () {
          //       onCancelTap!();
          //     },
          //     onOkayTapped: () {
          //       onOkayTap!();
          //     });
          case 'warning':
            dialog = Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: customWidget,
            );
          // WarningDialog(
          //     okayText: okayBtnText,
          //     cancelText: cancelBtnText,
          //     title: title,
          //     message: message,
          //     height: height,
          //     hasCancel: showCancelBtn,
          //     onCancelTapped: () {
          //       onCancelTap!();
          //     },
          //     onOkayTapped: () {
          //       onOkayTap!();
          //     });
          case 'custom':
            dialog = Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: customWidget,
            );
          default:
            dialog = Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: customWidget,
            );
            // SucessDialog(
            //     okayText: okayBtnText,
            //     cancelText: cancelBtnText,
            //     title: title,
            //     height: height,
            //     hasCancel: showCancelBtn,
            //     message: message,
            //     onCancelTapped: () {
            //       onCancelTap!();
            //     },
            //     onOkayTapped: () {
            //       onOkayTap!();
            //     });
            break;
        }

        return dialog;
      },
    );
  }
}
