import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/profile_provider.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/widgets/components/buttons/primary_button.dart';
import 'package:task_rm/widgets/components/custom_image_holder.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../utils/constant/constant.dart';
import 'image_delete_dialog.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final String userImage = '';
  final TextEditingController _nameController = TextEditingController();
  late bool isName = false;

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
        child: Consumer<ProfileProvider>(builder: (_, profileState, child) {
          return Column(
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
                      onTap: () async {
                        await profileState.saveProfile(
                            _nameController.text, '', '', '', '', '');
                      },
                      buttonTitle: 'Save',
                      buttonColor: _nameController.text.isEmpty || !isName
                          ? primaryLight
                          : primaryColor,
                      isLoading: profileState.isProfileDataSaving,
                    ),
                    primaryVerticalSpace
                  ],
                ),
              )
            ],
          );
        }),
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
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
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
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomImageHolder(
                    imageUrl: profileState.imageUrl,
                    isCircle: true,
                    height: 192,
                    width: 192,
                    errorWidget: SvgPicture.asset(
                      userProfileIcon,
                      height: 150,
                      width: 150,
                    )),
                sixteenVerticalSpace,
                userImage.isEmpty ? _addIcon() : _buildDeleteAndChangeButtons()
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
          onChanged: (value){
            setState(() {
              isName = true;
            });
          },
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

  Widget _addIcon() {
    return InkWell(
      onTap: () {
        _selectImageDialog(context);
      },
      child: Column(
        children: [
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
            style: tTextStyle500.copyWith(fontSize: 16, color: secondaryColor),
          )
        ],
      ),
    );
  }

  Widget _buildDeleteAndChangeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            CustomDialog.dialogBuilder(context, const ImageDeleteDialog());
          },
          child: Column(
            children: [
              SvgPicture.asset(imageDeleteIcon),
              Text(
                'Delete',
                style: tTextStyle500.copyWith(color: red, fontSize: 16),
              )
            ],
          ),
        ),
        primaryHorizontalSpace,
        Column(
          children: [
            SvgPicture.asset(imageEditIcon),
            Text(
              'Change',
              style:
                  tTextStyle500.copyWith(color: secondaryColor, fontSize: 16),
            )
          ],
        ),
      ],
    );
  }

  void _selectImageDialog(BuildContext context) {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Select Image',
              style:
                  tTextStyle500.copyWith(color: textPrimaryColor, fontSize: 18),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Gallery',
                  style: tTextStyle500.copyWith(
                      color: secondaryColor, fontSize: 16),
                ),
                onPressed: () async {
                  await profileState.pickImage(ImageSource.gallery, context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'Camera',
                  style: tTextStyle500.copyWith(
                      color: secondaryColor, fontSize: 16),
                ),
                onPressed: () async {
                  await profileState.pickImage(ImageSource.camera, context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'Back',
                  style: tTextStyle500.copyWith(color: red, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
