import 'package:TaskRM/providers/localization_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.g.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/profile_provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import 'package:TaskRM/widgets/components/custom_image_holder.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../utils/constant/constant.dart';
import 'image_delete_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final String userImage = '';
  late TextEditingController _nameController;
  late bool isName = false;

  @override
  void initState() {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    _nameController = TextEditingController(text: profileState.profileName);
    super.initState();
  }

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
                    _languageField(),
                    primaryVerticalSpace,
                    PrimaryButton(
                      onTap: () async {
                        await profileState.updateProfile(
                            profileState.profileImage,
                            _nameController.text,
                            profileState.profileEncryption,
                            profileState.profileJira,
                            profileState.profileJiraUserName,
                            profileState.profileJiraUrl,
                            profileState.language,
                            context);
                      },
                      buttonTitle: 'Save',
                      buttonColor: _nameController.text.isEmpty
                          ? primaryLight
                          : primaryColor,
                      isLoading: profileState.isProfileUpdating,
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
                    imageUrl: profileState.profileImage,
                    isCircle: true,
                    height: 192,
                    width: 192,
                    errorWidget: SvgPicture.asset(
                      userProfileIcon,
                      height: 150,
                      width: 150,
                    )),
                sixteenVerticalSpace,
                profileState.profileImage.isEmpty
                    ? _addIcon()
                    : _buildDeleteAndChangeButtons()
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
          // onChanged: (value){
          //   setState(() {
          //     isName = true;
          //   });
          // },
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
                AppLocalizations.of(context)!.delete,
                style: tTextStyle500.copyWith(color: red, fontSize: 16),
              )
            ],
          ),
        ),
        primaryHorizontalSpace,
        InkWell(
          onTap: () {
            _selectImageDialog(context);
          },
          child: Column(
            children: [
              SvgPicture.asset(imageEditIcon),
              Text(
                'Change',
                style:
                    tTextStyle500.copyWith(color: secondaryColor, fontSize: 16),
              )
            ],
          ),
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

  Column _languageField() {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    final localizationState =
        Provider.of<LocalizationProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: tTextStyle500.copyWith(fontSize: 20, color: textPrimaryColor),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: textFieldFillColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Image.asset(
                  profileState.language == 'en'
                      ? usaFlag
                      : profileState.language == 'is'
                          ? icelandFlag
                          : profileState.language == 'de'
                              ? germanyFlag
                              : norwegianFlag,
                  height: 32,
                  width: 32,
                ),
                sixteenHorizontalSpace,
                Expanded(
                  child: LanguagePickerDropdown(
                      initialValue: profileState.language == 'is'
                          ? Languages.icelandic
                          : profileState.language == 'de'
                              ? Languages.german
                              : profileState.language == 'no'
                                  ? Languages.norwegian
                                  : Languages.english,
                      languages: [
                        Languages.english,
                        Languages.icelandic,
                        Languages.german,
                        Languages.norwegian
                      ],
                      onValuePicked: (language) {
                        profileState.changeLanguage(language.isoCode);
                        localizationState.setLocale(Locale(language.isoCode));
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
