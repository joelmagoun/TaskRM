import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/color.dart';
import '../../../utils/typograpgy.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onTap;
  final double fontSize;
  final bool isLoading;
  final Color buttonColor;
  final Color buttonTitleColor;

  const PrimaryButton(
      {Key? key,
      required this.onTap,
      required this.buttonTitle,
      this.fontSize = 20.0,
      this.isLoading = false,
      this.buttonColor = primaryColor,
      this.buttonTitleColor = white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 0.0,
          backgroundColor: buttonColor,
          textStyle: title2,
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: white.withOpacity(0.5),
              ))
            : Text(
                buttonTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: tTextStyle600.copyWith(fontSize: 16, color: white),
              ),
      ),
    );
  }
}
