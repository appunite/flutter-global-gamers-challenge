import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class CustomSnackBarBuilder extends SnackBar {
  CustomSnackBarBuilder({
    super.key,
    required this.title,
    required this.icon,
    this.seconds,
  }) : super(
          content: SnackBarContent(
            title: title,
            icon: icon,
          ),
          backgroundColor: Palette.neutralWhite,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: Duration(seconds: seconds ?? 2),
        );

  final String title;
  final int? seconds;
  final Widget icon;
}

class SnackBarContent extends StatelessWidget {
  const SnackBarContent({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        gap4,
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
