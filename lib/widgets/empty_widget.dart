import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/color.dart';
import '../utils/spacer.dart';
import '../utils/typograpgy.dart';

class EmptyWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;

  const EmptyWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          height: 120,
          width: 120,
          color: assColor,
        ),
        sixteenVerticalSpace,
        Text(
          title,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: tTextStyleRegular.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
