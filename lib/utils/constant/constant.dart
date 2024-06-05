import 'package:flutter/material.dart';
import '../color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    '0',
    '1',
    '3',
    '7',
    '14',
    '30',
    '90',
    '365'
  ];

  /// type list ///

  static final List<String> typeList = ['1', '2', '3'];

  /// convert type ///
  static String convertType(BuildContext context, String code){
    switch (code) {
      case "1":
        return AppLocalizations.of(context)!.work;
      case "2":
        return AppLocalizations.of(context)!.personalproject;
      case "3":
        return AppLocalizations.of(context)!.self;
      default:
        return 'Error';
    }
  }

  /// convert time frame ///
  static String convertPriority(BuildContext context, String code){
    switch (code) {
      case "1":
        return AppLocalizations.of(context)!.needstobedone;
      case "2":
        return AppLocalizations.of(context)!.nicetohave;
      case "3":
        return AppLocalizations.of(context)!.niceidea;
      default:
        return 'Error';
    }
  }

  /// convert time frame ///
  static String convertTimeFrame(BuildContext context, String code){
    switch (code) {
      case "0":
        return AppLocalizations.of(context)!.none;
      case "1":
        return AppLocalizations.of(context)!.today;
      case"3":
        return AppLocalizations.of(context)!.threedays;
      case "7":
        return AppLocalizations.of(context)!.week;
      case "14":
        return AppLocalizations.of(context)!.fortnight;
      case "30":
        return AppLocalizations.of(context)!.month;
      case "90":
        return AppLocalizations.of(context)!.ninteydays;
      case "365":
        return AppLocalizations.of(context)!.year;
      default:
        return 'Error';
    }
  }

  /// convert time frame ///
  static String convertParentGoal(String code){
    switch (code) {
      case "0":
        return 'None';
      case "1":
        return 'Work towards obtaining certifications that are valuable...';
      case "2":
        return 'Read 4 of self-improvement books within the next six mon...';
      default:
        return 'Explore and participate in adventurous activities.';
    }
  }


  /// user image url ///

  static String userImageUrl = '';

 /// base url ///
static const baseUrl = 'http://arabic.live.pwtech.pw:9001/';

}
//http://localhost:9000/
//arabic.live.pwtech.pw:9001