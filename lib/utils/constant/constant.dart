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

  static final List<String> typeList = ['Work', 'Personal Project', 'Self'];


  /// user image url ///

  static String userImageUrl = '';

 /// base url ///
static const baseUrl = 'http://arabic.live.pwtech.pw:9001/';

}
//http://localhost:9000/
//arabic.live.pwtech.pw:9001