import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/auth_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/buttons/custom_outline_button.dart';

class LogoutDeleteDialog extends StatelessWidget {
  const LogoutDeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, authState, child){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Log out',
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
              onTap: () async {
                await authState.logout(context);
              },
              buttonTitle: 'Log me out',
              borderColor: borderColor,
              titleColor: red,
              isLoading: authState.isLogOut,
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
