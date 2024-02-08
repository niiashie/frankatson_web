// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
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
      bool showCancelBtn = true,
      String? notice,
      double? width = 350,
      bool showButtons = true,
      bool hasCustomWidget = false,
      Widget? customWidget}) {
    return showDialog(
      context: StackedService.navigatorKey!.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Icon(
                        Icons.clear,
                        color: Colors.grey,
                        size: 17,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  message!,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Visibility(
                  visible: hasCustomWidget,
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                Visibility(
                    visible: hasCustomWidget,
                    child: customWidget == null ? Container() : customWidget),
                SizedBox(
                  height: showButtons == true ? 20 : 10,
                ),
                Visibility(
                    visible: showButtons,
                    child: SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: showCancelBtn,
                              child: Material(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      cancelBtnText,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  onTap: () {
                                    onCancelTap!();
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: showCancelBtn,
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    okayBtnText,
                                    style:
                                        TextStyle(color: AppColors.gradient2),
                                  ),
                                ),
                                onTap: () {
                                  onOkayTap!();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}
