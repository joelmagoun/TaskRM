import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:task_rm/utils/typograpgy.dart';

import 'color.dart';

class CustomSnack {

  static void successSnack(String message, BuildContext context) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: secondaryColor,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Congratulations!",
              style: tTextStyle800.copyWith(fontSize: 16, color: white),
            ),
            Text(
              message,
              style: tTextStyle600.copyWith(fontSize: 14, color: white),
            ),
          ],
        )));
  }

  static void warningSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: primaryColor,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Warning!",
              style: tTextStyle800.copyWith(fontSize: 16, color: white),
            ),
            Text(
              message,
              style: tTextStyle600.copyWith(fontSize: 14, color: white),
            ),
          ],
        )));
  }

}
