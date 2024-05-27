import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/profile_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/buttons/custom_outline_button.dart';

class ImageDeleteDialog extends StatelessWidget {
  const ImageDeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, profileState, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Delete profile photo',
            style:
                tTextStyle500.copyWith(fontSize: 18, color: textPrimaryColor),
          ),
          eightVerticalSpace,
          Text(
            'Are you sure?',
            style: tTextStyleRegular.copyWith(
                fontSize: 14, color: const Color(0xFF555555)),
          ),
          primaryVerticalSpace,
          CustomOutlineButton(
            onTap: () {
              profileState.deleteImage(context);
            },
            buttonTitle: 'Yes, delete',
            borderColor: borderColor,
            titleColor: red,
            isLoading: profileState.isImageDeleting,
          ),
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
    });
  }
}
