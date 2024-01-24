import 'package:flutter/material.dart';

class DialogHelper {
  static void showWithWidgetBinding(BuildContext context, Widget widget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => widget,
      );
    });
  }

  static Future<void> show(BuildContext context, Widget widget) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => widget,
    );
  }
}
