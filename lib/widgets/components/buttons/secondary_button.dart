import 'package:flutter/material.dart';
import '../../../utils/color.dart';
import '../../../utils/typograpgy.dart';

class SecondaryButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onTap;
  final double fontSize;
  final bool isLoading;
  final Color buttonColor;
  final Color buttonTitleColor;

  const SecondaryButton(
      {Key? key,
      required this.onTap,
      required this.buttonTitle,
      this.fontSize = 20.0,
      this.isLoading = false,
      required this.buttonColor,
      required this.buttonTitleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 50,
      width: screenWidth / 2.5,
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
                style: subtitle2.copyWith(color: buttonTitleColor, fontSize: fontSize),
              ),
      ),
    );
  }
}
