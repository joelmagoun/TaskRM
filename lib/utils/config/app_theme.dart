import 'package:flutter/material.dart';
import 'package:TaskRM/utils/config/typography.dart';

class AppTheme {
  static Color primaryColor = const Color(0xff4942E4);

  static ThemeData get light {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
    );
    final ThemeData base = ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      }),
      brightness: Brightness.light,
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      primaryColorDark: primaryColor,
      appBarTheme:
          const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
      indicatorColor: Colors.white,
      cardColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xffF9F9F9),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
        height: 48,
        buttonColor: primaryColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      fontFamily: AppTypography.poppinsFont,
    );
    return base;
  }
}
