import 'package:flutter/material.dart';
import 'package:task_rm/utils/typograpgy.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonTitle;
  final Color borderColor;
  final Color titleColor;
  final bool isLoading;

  const CustomOutlineButton(
      {Key? key,
      required this.onTap,
      required this.buttonTitle,
      required this.borderColor,
      required this.titleColor,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Text(
                buttonTitle,
                style: tTextStyle600.copyWith(color: titleColor, fontSize: 16),
              ),
      ),
    );
  }
}
