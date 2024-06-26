import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/profile_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/buttons/custom_outline_button.dart';

class JiraDeleteDialog extends StatelessWidget {
  final String docId;

  const JiraDeleteDialog({Key? key, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, profileState, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Delete connection',
            style:
                tTextStyle500.copyWith(fontSize: 18, color: textPrimaryColor),
          ),
          primaryVerticalSpace,
          CustomOutlineButton(
            onTap: () {
              profileState.deleteJiraConnection(docId, context);
            },
            buttonTitle: 'Delete',
            borderColor: borderColor,
            titleColor: red,
           // isLoading: profileState.isJiraDeleting,
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
