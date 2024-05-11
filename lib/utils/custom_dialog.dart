import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'color.dart';

class CustomDialog {

  // static void actionDialog(){
  //   Get.defaultDialog(
  //     // title: 'Congratulations !',
  //       backgroundColor: white,
  //       barrierDismissible: true,
  //       radius: 16,
  //       content: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           children: [
  //               Text('Check your email and go to Login Screen',style: bodyText2.copyWith(color: black),),
  //             primaryVerticalSpace,
  //             PrimaryButton(buttonTitle: 'Back to Login', onTap: (){
  //              // Get.to(()=> const LoginScreen());
  //               //  Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen()));
  //             },isLoading: false,)
  //           ],),
  //       ));
  // }

  static Future<void> dialogBuilder(BuildContext context, Widget column) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData(dialogBackgroundColor: Colors.white),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: white,
            content: column,
          ),
        );
      },
    );
  }

  static Future<void> autoDialog(BuildContext context, IconData icon, String message) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                    radius: 24,
                    backgroundColor: primaryLight,
                    child: Icon(
                      icon,
                      color: primaryColor,
                    )),
                sixteenVerticalSpace,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: subtitle2.copyWith(color: black),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> bottomSheet(BuildContext context, Widget content){
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => content,
    );
  }

}