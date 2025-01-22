

import 'package:flutter/material.dart';
import 'package:jeevan_weather_task/enums/enums.dart';
import 'package:logger/logger.dart';
import 'utils.dart';



abstract class Utility {


  // SnackBar
  static void showSnackbar(BuildContext context, String? message, TypeOfMessage messageType) {

    ScaffoldMessenger.of(context).clearSnackBars();

    if (message == null || message.isEmpty) return;
    var backgroundColor = Colors.black;
    switch (messageType) {
      case TypeOfMessage.error:
        backgroundColor = AppColors.redColor;
        break;
      case TypeOfMessage.information:
        // backgroundColor = Colors.black.withOpacity(0.3);
        backgroundColor = AppColors.blackColorWithOpacity0_3;
        break;
      case TypeOfMessage.success:
        backgroundColor = AppColors.greenColor;
        break;
      // default:
      //   backgroundColor = Colors.black;
      //   break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );
  }


  static Future<void> showLoadingDialog(
      context)
  async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    height: 80,
                    width: 80,
                    child: const CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                      strokeWidth: 5,
                    ),
                  ),
                ),
          );
        });
  }


  static Future<void> hideDialog(
      BuildContext context)
  async {
    Navigator.of(context).pop();
  }


  // coverage:ignore-start
  static void printDLog(String message) {
    Logger().d('${StringConstants.appName}: $message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printILog(dynamic message) {
    Logger().i('${StringConstants.appName}: $message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printLog(dynamic message) {
    Logger().log(Level.info, message);
  }

  /// Print error log.
  ///
  /// [message] : The message which needed to be print.
  static void printELog(String message) {
    Logger().e('${StringConstants.appName}: $message');
  }

}