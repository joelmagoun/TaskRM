import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/views/profile/widgets/edit_profile_bottomsheet.dart';
import 'package:task_rm/widgets/components/buttons/custom_outline_button.dart';
import '../../utils/color.dart';
import '../../utils/typograpgy.dart';
import '../../widgets/components/buttons/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool isLoading = false;
  final String userImage = '';

  @override
  void initState() {
    //final profileState = Provider.of<ProfileProvider>(context, listen: false);
    //profileState.getProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
        title: Text(
          'Profile',
          style: tTextStyle500.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            sixteenVerticalSpace,
            _buildUserImage(),
            sixteenVerticalSpace,
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: textFieldFillColor,
                  child: SvgPicture.asset(jiraIcon),
                ),
                eightHorizontalSpace,
                Text(
                  'Jira connections',
                  style: tTextStyleRegular.copyWith(
                      fontSize: 16, color: textPrimaryColor),
                )
              ],
            ),
            const Spacer(),
            CustomOutlineButton(
                onTap: () {},
                buttonTitle: 'Log out',
                borderColor: borderColor,
                titleColor: iconColor),
            primaryVerticalSpace
          ],
        ),
      ),
    );
  }

  Widget _buildUserImage() {
    return InkWell(
      onTap: () {
        CustomDialog.bottomSheet(context, const EditProfileBottomSheet());
      },
      child: Container(
        alignment: Alignment.center,
        height: 175,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: textFieldFillColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: trans,
              backgroundImage:
                  userImage.isEmpty ? null : NetworkImage(dummyProfileImage),
              child:
                  userImage.isEmpty ? SvgPicture.asset(userProfileIcon) : null,
            ),
            eightVerticalSpace,
            Text('UserName',
                style: tTextStyle500.copyWith(
                    color: textPrimaryColor, fontSize: 20))
          ],
        ),
      ),
    );
  }
}
