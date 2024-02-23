import 'package:flutter/material.dart';

class AppTypography {
  static const textDefaultColor = Color(0xff404040);

  static const poppinsFont = "Poppins";

  static const title = TextStyle(
    color: textDefaultColor,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w400,
    fontSize: 22.0,
    height: 1.5,
  );

  static const title2 = TextStyle(
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    height: 1.5,
  );

  static const subtitle = TextStyle(
    color: textDefaultColor,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    height: 1.5,
  );

  static const subtitle2 = TextStyle(
    color: textDefaultColor,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    height: 1.5,
  );

  static const caption = TextStyle(
    color: textDefaultColor,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    height: 1.5,
  );

  static const headline1 = TextStyle(
    color: textDefaultColor,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.5,
  );

  static const headline3 = TextStyle(
    color: textDefaultColor,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w600,
    fontSize: 30.0,
    height: 1.5,
  );

  static const input = TextStyle(
    color: textDefaultColor,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    height: 1.5,
  );

  static const button = TextStyle(
    color: Colors.white,
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
    height: 1.5,
  );

  static const dropdown = TextStyle(
    fontFamily: poppinsFont,
    color: textDefaultColor,
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    height: 1.5,
  );
}
