import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {

  Locale _locale = Locale('en');

  Locale get local => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  LocalizationProvider() {
    _init();
  }

  _init() {
    // getLocale().then((value){
    //   _locale = value;
    //   notifyListener();
    // });
  }


}
