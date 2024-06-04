import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/auth_provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/views/profile/widgets/edit_profile_bottomsheet.dart';
import 'package:TaskRM/views/profile/widgets/logout_dialog.dart';
import 'package:TaskRM/widgets/components/buttons/custom_outline_button.dart';
import 'package:TaskRM/widgets/components/custom_image_holder.dart';
import '../../providers/profile_provider.dart';
import '../../routes/routes.dart';
import '../../utils/color.dart';
import '../../utils/typograpgy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    profileState.getProfileInfo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: tTextStyle500.copyWith(fontSize: 20),
        ),
      ),
      body: Consumer2<AuthProvider, ProfileProvider>(
          builder: (_, authState, profileState, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: profileState.isProfileDataLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    sixteenVerticalSpace,
                    _buildUserImage(),
                    sixteenVerticalSpace,
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.jiraCollectionScreen);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: textFieldFillColor,
                            child: SvgPicture.asset(jiraIcon),
                          ),
                          eightHorizontalSpace,
                          Text(
                            AppLocalizations.of(context)!.jiraconns,
                            style: tTextStyleRegular.copyWith(
                                fontSize: 16, color: textPrimaryColor),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    CustomOutlineButton(
                      onTap: () {
                        CustomDialog.dialogBuilder(
                            context, const LogoutDeleteDialog());
                      },
                      buttonTitle: AppLocalizations.of(context)!.logout,
                      borderColor: borderColor,
                      titleColor: iconColor,
                    ),
                    primaryVerticalSpace
                  ],
                ),
        );
      }),
    );
  }

  Widget _buildUserImage() {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
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
            CustomImageHolder(
                imageUrl: profileState.profileImage,
                height: 96,
                width: 96,
                errorWidget: SvgPicture.asset(userProfileIcon)),
            eightVerticalSpace,
            Text(profileState.profileName,
                style: tTextStyle500.copyWith(
                    color: textPrimaryColor, fontSize: 20))
          ],
        ),
      ),
    );
  }
}
