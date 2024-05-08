import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/newTask/add_new_task_bottomsheet.dart';
import 'package:task_rm/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../utils/constant/constant.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final String userImage = 'xcxz';
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            eightVerticalSpace,
            _header(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _imageField(),
                  primaryVerticalSpace,
                  _buildNameField(),
                  primaryVerticalSpace,
                  PrimaryButton(
                    onTap: () {},
                    buttonTitle: 'Save',
                    buttonColor: primaryLight,
                  ),
                  primaryVerticalSpace
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear,
              color: trans,
            )),
        Text(
          'Edit profile details',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: iconColor,
            )),
      ],
    );
  }

  Widget _imageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile photo',
          style: tTextStyle500.copyWith(fontSize: 20, color: textPrimaryColor),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          //height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            //color: const Color(0xFFE5E5E5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 96,
                  backgroundColor: textFieldFillColor,
                  backgroundImage: userImage.isEmpty
                      ? null
                      : NetworkImage(dummyProfileImage),
                  child: userImage.isEmpty
                      ? SvgPicture.asset(
                          userProfileIcon,
                          height: 150,
                          width: 150,
                        )
                      : null,
                ),
                sixteenVerticalSpace,
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: textFieldFillColor,
                  child: Icon(
                    Icons.add,
                    color: black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Add',
                  style: tTextStyle500.copyWith(
                      fontSize: 16, color: secondaryColor),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: tTextStyle500.copyWith(fontSize: 20, color: textPrimaryColor),
        ),
        TextFormField(
          controller: _nameController,
          autofocus: false,
          cursorColor: primaryColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: white,
            contentPadding: const EdgeInsets.all(12),
            hintText: 'User name',
            hintStyle: hintTextStyle,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: borderColor),
            ),
            errorBorder: AppConstant.outlineErrorBorder,
            focusedErrorBorder: AppConstant.outlineErrorBorder,
            focusColor: primaryColor,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}
