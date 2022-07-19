import 'package:flutter/material.dart';

class SnackBarWidget {
  static void call(
      {required Color backgroundColor,
      required String message,
      required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
