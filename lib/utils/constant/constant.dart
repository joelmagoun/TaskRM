import 'package:flutter/material.dart';
import '../color.dart';


class AppConstant{

  static final divider = Divider(color: borderColor);

  static final focusOutLineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: secondaryColor),
  );

  static final enableOutLineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: trans),
  );

  static final outlineErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: red, width: 1.0),
  );

  static final primaryRadius = BorderRadius.circular(12);


  /// time frame list ///

  static final List<String> timeFrameList = [
    'Today',
    '3 days',
    'Week',
    'Fortnight',
    'Month',
    '90 days',
    'Year'
  ];

  /// type list ///

  static final List<String> typeList = ['1', '2', '3'];

  /// convert type ///
  static String convertType(String code){
    switch (code) {
      case "1":
        return 'Work';
      case "2":
        return 'Personal Project';
      default:
        return 'Self';
    }
  }

  /// convert time frame ///
  static String convertPriority(String code){
    switch (code) {
      case "1":
        return 'Needs to be done';
      case "2":
        return 'Nice to have';
      default:
        return 'Nice idea';
    }
  }

  /// convert time frame ///
  static String convertTimeFrame(String code){
    switch (code) {
      case "0":
        return 'None';
      case "1":
        return 'Today';
      case "7":
        return 'Week';
      case "14":
        return 'Fortnight';
      case "30":
        return 'Month';
      case "90":
        return '90 days';
      default:
        return 'Year';
    }
  }


  /// user image url ///

  static String userImageUrl = '';

 /// base url ///
static const baseUrl = 'http://arabic.live.pwtech.pw:9001/';

}
//http://localhost:9000/
//arabic.live.pwtech.pw:9001