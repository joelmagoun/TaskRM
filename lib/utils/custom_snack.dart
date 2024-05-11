import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'color.dart';

class CustomSnack {
  static void successSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      backgroundColor: white,
      content: ContentCart(isSuccess: true, message: message),
    ));
  }

  static void warningSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
        backgroundColor: white,
        content: ContentCart(isSuccess: false, message: message),
    ));
  }
}

class ContentCart extends StatelessWidget {
  final bool isSuccess;
  final String message;

  const ContentCart({Key? key, required this.isSuccess, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE9E9E9)),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.06),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
          color: white),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle_rounded : Icons.warning,
              color: isSuccess ? const Color(0xFF2AD6B7) : red,
            ),
            sixteenHorizontalSpace,
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                message,
                style:
                    tTextStyleRegular.copyWith(fontSize: 14, color: Colors.black),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.clear,
              color: iconColor,
            )
          ],
        ),
      ),
    );
  }
}
