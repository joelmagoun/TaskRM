import 'package:flutter/material.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/widgets/components/buttons/custom_outline_button.dart';

class ImageDeleteDialog extends StatelessWidget {
  const ImageDeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Delete profile photo',
          style: tTextStyle500.copyWith(fontSize: 18, color: textPrimaryColor),
        ),
        eightVerticalSpace,
        Text(
          'Are you sure?',
          style: tTextStyleRegular.copyWith(
              fontSize: 14, color: const Color(0xFF555555)),
        ),
        primaryVerticalSpace,
        CustomOutlineButton(
            onTap: () {},
            buttonTitle: 'Yes, delete',
            borderColor: borderColor,
            titleColor: red),
        eightVerticalSpace,
        CustomOutlineButton(
            onTap: () {
              Navigator.pop(context);
            },
            buttonTitle: 'Cancel',
            borderColor: borderColor,
            titleColor: iconColor),
      ],
    );
  }
}
