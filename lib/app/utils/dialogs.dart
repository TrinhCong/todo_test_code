import 'dart:async';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';

class Dialogs {
  static _(BuildContext context, String key) => "__dialogUtils__";

  static Future<void> alert(
      {String title = "Thông báo", required String message}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: title,
        middleText: message,
        confirm: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
            decoration: BoxDecoration(
                color: AppTheme.successColor,
                borderRadius: BorderRadius.circular(24)),
            child: Text("Ok",
                style: TextStyle(
                    color: AppTheme.brightColor, fontWeight: FontWeight.bold)),
          ),
        ));
  }
  static Future<bool> confirm({String? title, required String message}) async {
    var ok = await Get.dialog<bool>(
      SafeArea(child: Builder(builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Column(
              children: <Widget>[
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColorLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          title ?? "Xác nhận",
                          style: TextStyle(
                              color: AppTheme.primaryColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.h),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontSize: 14.h,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: AppTheme.errorColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          color: AppTheme.brightColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text("Ok",
                                      style: TextStyle(
                                          color: AppTheme.brightColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      })),
      barrierDismissible: false,
    );
    return ok ?? false;
  }

  static Future<bool> showAd({required Widget addWidget}) async {
    var ok = await Get.dialog<bool>(
      SafeArea(child: Builder(builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Column(
              children: <Widget>[
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColorLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [Spacer(), Icon(Icons.close)],
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                          child: addWidget),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      })),
      barrierDismissible: false,
    );
    return ok ?? false;
  }

  static Future<double?> promptCurrentcy(
      {String? title, String? message, String? value}) async {
    final inputController = TextEditingController(text: value);
    double _value = 0;
    return await showDialog<double>(
      context: Get.context as BuildContext,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: StatefulBuilder(builder: (context, setState) {
            inputController.addListener(() {
              setState(() {
                _value = double.tryParse(inputController.text) ?? 0;
              });
            });
            return Material(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColorLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              title ?? "Nhập dữ liệu",
                              style: TextStyle(
                                  color: AppTheme.primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.h),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      message ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme.textColor,
                                        fontSize: 14.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextField(
                                      controller: inputController,
                                      style: TextStyle(fontSize: 18.h),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(1),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: AppTheme
                                                      .primaryColorLight,
                                                  width: 1))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: AppTheme.errorColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Cancel",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (_value > 0) Get.back(result: _value);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: _value > 0
                                              ? AppTheme.primaryColor
                                              : Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Ok",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
        );
      },
      barrierDismissible: false,
    );
  }

  static Future<String?> prompt(
      {required BuildContext context,
      String? title,
      String? message,
      String? value,
      bool obscured = false}) async {
    final inputController = TextEditingController(text: value);
    String? _password;
    return await showDialog<String>(
      context: context,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: StatefulBuilder(builder: (context, setState) {
            inputController.addListener(() {
              setState(() {
                _password = inputController.text;
              });
            });
            return Material(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColorLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              title ?? "Xác nhận",
                              style: TextStyle(
                                  color: AppTheme.primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.h),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      message ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme.textColor,
                                        fontSize: 14.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextField(
                                      controller: inputController,
                                      obscureText: obscured,
                                      style: TextStyle(fontSize: 18.h),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(1),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: AppTheme
                                                      .primaryColorLight,
                                                  width: 1))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context, null);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: AppTheme.errorColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Cancel",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: StringUtils.isNotNullOrEmpty(
                                            _password)
                                        ? () {
                                            Navigator.pop(context, _password);
                                          }
                                        : null,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: StringUtils.isNotNullOrEmpty(
                                                  _password)
                                              ? AppTheme.primaryColor
                                              : Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Ok",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
        );
      },
      barrierDismissible: false,
    );
  }

  static hideProgress() {
    Get.back();
  }

  static Future<Dialog?> showProgress({String? message}) {
    return Get.generalDialog(
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (context) {
            return Material(
              color: AppTheme.backgroundColor.withOpacity(0.1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width * .86,
                      decoration: BoxDecoration(
                          color: AppTheme.backgroundColorLight,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 8,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              message ?? "Please wait...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.textColor,
                                fontSize: 14.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(Get.context as BuildContext)
          .modalBarrierDismissLabel,
      barrierColor: Colors.white.withOpacity(0),
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

  static Future<String> showChoices({
    required BuildContext context,
    String title = "",
    required String message,
    required Color color,
    required Widget icon,
    required List<DialogChoiceItem> buttons,
  }) async {
    var result = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: color))),
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: SizedBox(
                          child: icon,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 35),
                          child: Center(
                            child: Text(
                              StringUtils.isNullOrEmpty(title)
                                  ? "Xác nhận"
                                  : title,
                              style: TextStyle(
                                  fontFamily: 'Todoo-Condensed',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: color),
                            ),
                          ),
                        ),
                      )
                    ]),
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message,
                    style: TextStyle(
                      fontFamily: 'Todoo-Condensed',
                      fontSize: 14.h,
                      color: AppTheme.textColor,
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buttons
                    .map(
                      (item) => Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(item.value);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          margin: EdgeInsets.only(left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: item.color),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                child: item.icon,
                                padding: EdgeInsets.all(1),
                              ),
                              Text(
                                item.text,
                                style: TextStyle(
                                  color: AppTheme.backgroundColorLight,
                                  fontSize: 13.h,
                                  fontFamily: 'Todoo-Condensed',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    )
                    .toList(),
              ),
            )
          ],
        );
      },
    );
    return result;
  }

  static Future<String> showSpecialConfirm({
    required BuildContext context,
    String title = "",
    required String message,
    required Color color,
    required Widget icon,
    required List<DialogChoiceItem> buttons,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static successSnack({required String message, Icon? icon}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Color(0xFFcfffc6),
      overlayColor: Colors.black,
      borderColor: Colors.blue.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      borderRadius: 24,
      messageText: Text(
        message,
        style: TextStyle(color: AppTheme.successColor),
      ),
      duration: Duration(seconds: 3),
      isDismissible: true,
      shouldIconPulse: true,
      icon: icon,
    ));
  }

  static errorSnack({required String message, Icon? icon}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Color(0xFFFFC6C6),
      overlayColor: Colors.black,
      borderColor: Colors.blue.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      borderRadius: 24,
      messageText: Text(
        message,
        style: TextStyle(color: AppTheme.errorColor),
      ),
      duration: Duration(seconds: 3),
      isDismissible: true,
      shouldIconPulse: true,
      icon: icon,
    ));
  }
}

class DialogChoiceItem {
  final String value;
  final String text;
  final Color color;
  final Widget icon;
  DialogChoiceItem(
      {required this.text,
      required this.value,
      required this.color,
      required this.icon});
}
