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
                      buttonTitle: AppLocalizations.of(context)!.save,
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
          AppLocalizations.of(context)!.editprofiledetails,
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
          AppLocalizations.of(context)!.profilephoto,
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
          AppLocalizations.of(context)!.name,
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
            hintText: AppLocalizations.of(context)!.username,
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
            AppLocalizations.of(context)!.add,
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
                AppLocalizations.of(context)!.change,
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
              AppLocalizations.of(context)!.selectimage,
              style:
                  tTextStyle500.copyWith(color: textPrimaryColor, fontSize: 18),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  AppLocalizations.of(context)!.gallery,
                  style: tTextStyle500.copyWith(
                      color: secondaryColor, fontSize: 16),
                ),
                onPressed: () async {
                  await profileState.pickImage(ImageSource.gallery, context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  AppLocalizations.of(context)!.camera,
                  style: tTextStyle500.copyWith(
                      color: secondaryColor, fontSize: 16),
                ),
                onPressed: () async {
                  await profileState.pickImage(ImageSource.camera, context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  AppLocalizations.of(context)!.back,
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
          AppLocalizations.of(context)!.language,
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
                              : profileState.language == 'it'
                              ? italyFlag
                              : profileState.language == 'af'
                              ? southafricaFlag
                              : profileState.language == 'bn'
                              ? bangladeshFlag
                              : profileState.language == 'ca'
                              ? cataloniaFlag
                              : profileState.language == 'cs'
                              ? czechFlag
                              : profileState.language == 'cy'
                              ? walesFlag
                              : profileState.language == 'da'
                              ? denmarkFlag
                              : profileState.language == 'el'
                              ? greeceFlag
                              : profileState.language == 'es'
                              ? spainFlag
                              : profileState.language == 'et'
                              ? estoniaFlag
                              : profileState.language == 'eu'
                              ? basqueFlag
                              : profileState.language == 'fa'
                              ? persiaFlag
                              : profileState.language == 'fi'
                              ? finlandFlag
                              : profileState.language == 'fr'
                              ? franceFlag
                              : profileState.language == 'gl'
                              ? galaciaFlag
                              : profileState.language == 'he'
                              ? israelFlag
                              : profileState.language == 'hi'
                              ? hindiFlag
                              : profileState.language == 'hr'
                              ? croatiaFlag
                              : profileState.language == 'hu'
                              ? hungaryFlag
                              : profileState.language == 'hy'
                              ? armeniaFlag
                              : profileState.language == 'id'
                              ? indonesiaFlag
                              : profileState.language == 'ja'
                              ? japanFlag
                              : profileState.language == 'kn'
                              ? kannadaFlag
                              : profileState.language == 'ko'
                              ? koreaFlag
                              : profileState.language == 'lo'
                              ? laosFlag
                              : profileState.language == 'lt'
                              ? lithuaniaFlag
                              : profileState.language == 'lv'
                              ? latviaFlag
                              : profileState.language == 'mk'
                              ? macedoniaFlag
                              : profileState.language == 'ne'
                              ? nepalFlag
                              : profileState.language == 'nl'
                              ? netherlandsFlag
                              : profileState.language == 'pa'
                              ? punjabFlag
                              : profileState.language == 'pl'
                              ? polandFlag
                              : profileState.language == 'pt'
                              ? portugalFlag
                              : profileState.language == 'ro'
                              ? romaniaFlag
                              : profileState.language == 'ru'
                              ? russiaFlag
                              : profileState.language == 'sl'
                              ? sloveniaFlag
                              : profileState.language == 'sv'
                              ? swedenFlag
                              : profileState.language == 'ta'
                              ? tamilFlag
                              : profileState.language == 'te'
                              ? teluguFlag
                              : profileState.language == 'th'
                              ? thailandFlag
                              : profileState.language == 'tr'
                              ? turkeyFlag
                              : profileState.language == 'uk'
                              ? ukraineFlag
                              : profileState.language == 'ur'
                              ? pakistanFlag
                              : profileState.language == 'vi'
                              ? vietnamFlag
                              : profileState.language == 'zh'
                              ? chinaFlag
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
                                  : profileState.language == 'it'
                                  ? Languages.italian
                                  : profileState.language == 'af'
                                  ? Languages.afrikaans
                                  : profileState.language == 'bn'
                                  ? Languages.bengali
                                  : profileState.language == 'ca'
                                  ? Languages.catalan
                                  : profileState.language == 'cs'
                                  ? Languages.czech
                                  : profileState.language == 'cy'
                                  ? Languages.welsh
                                  : profileState.language == 'da'
                                  ? Languages.danish
                                  : profileState.language == 'el'
                                  ? Languages.greek
                                  : profileState.language == 'es'
                                  ? Languages.spanish
                                  : profileState.language == 'et'
                                  ? Languages.estonian
                                  : profileState.language == 'eu'
                                  ? Languages.basque
                                  : profileState.language == 'fa'
                                  ? Languages.persian
                                  : profileState.language == 'fi'
                                  ? Languages.finnish
                                  : profileState.language == 'fr'
                                  ? Languages.french
                                  : profileState.language == 'gl'
                                  ? Languages.galician
                                  : profileState.language == 'he'
                                  ? Languages.hebrew
                                  : profileState.language == 'hi'
                                  ? Languages.hindi
                                  : profileState.language == 'hr'
                                  ? Languages.croatian
                                  : profileState.language == 'hu'
                                  ? Languages.hungarian
                                  : profileState.language == 'hy'
                                  ? Languages.armenian
                                  : profileState.language == 'id'
                                  ? Languages.indonesian
                                  : profileState.language == 'ja'
                                  ? Languages.japanese
                                  : profileState.language == 'kn'
                                  ? Languages.kannada
                                  : profileState.language == 'ko'
                                  ? Languages.korean
                                  : profileState.language == 'lo'
                                  ? Languages.lao
                                  : profileState.language == 'lt'
                                  ? Languages.lithuanian
                                  : profileState.language == 'lv'
                                  ? Languages.latvian
                                  : profileState.language == 'mk'
                                  ? Languages.macedonian
                                  : profileState.language == 'ne'
                                  ? Languages.nepali
                                  : profileState.language == 'nl'
                                  ? Languages.dutch
                                  : profileState.language == 'pa'
                                  ? Languages.panjabi
                                  : profileState.language == 'pl'
                                  ? Languages.polish
                                  : profileState.language == 'pt'
                                  ? Languages.portuguese
                                  : profileState.language == 'ro'
                                  ? Languages.romanian
                                  : profileState.language == 'ru'
                                  ? Languages.russian
                                  : profileState.language == 'sl'
                                  ? Languages.slovenian
                                  : profileState.language == 'sv'
                                  ? Languages.swedish
                                  : profileState.language == 'ta'
                                  ? Languages.tamil
                                  : profileState.language == 'te'
                                  ? Languages.telugu
                                  : profileState.language == 'th'
                                  ? Languages.thai
                                  : profileState.language == 'tr'
                                  ? Languages.turkish
                                  : profileState.language == 'uk'
                                  ? Languages.ukrainian
                                  : profileState.language == 'ur'
                                  ? Languages.urdu
                                  : profileState.language == 'vi'
                                  ? Languages.vietnamese
                                  : profileState.language == 'zh'
                                  ? Languages.chineseSimplified
                                  : Languages.english,
                      languages: [
                        Languages.english,
                        Languages.icelandic,
                        Languages.german,
                        Languages.norwegian,
                        Languages.italian,
                        Languages.afrikaans,
                        Languages.bengali,
                        Languages.catalan,
                        Languages.czech,
                        Languages.welsh,
                        Languages.danish,
                        Languages.greek,
                        Languages.spanish,
                        Languages.estonian,
                        Languages.basque,
                        Languages.persian,
                        Languages.finnish,
                        Languages.french,
                        Languages.galician,
                        Languages.hebrew,
                        Languages.hindi,
                        Languages.croatian,
                        Languages.hungarian,
                        Languages.armenian,
                        Languages.indonesian,
                        Languages.japanese,
                        Languages.kannada,
                        Languages.korean,
                        Languages.lao,
                        Languages.lithuanian,
                        Languages.latvian,
                        Languages.macedonian,
                        Languages.nepali,
                        Languages.dutch,
                        Languages.panjabi,
                        Languages.polish,
                        Languages.portuguese,
                        Languages.romanian,
                        Languages.russian,
                        Languages.slovenian,
                        Languages.swedish,
                        Languages.tamil,
                        Languages.telugu,
                        Languages.thai,
                        Languages.turkish,
                        Languages.ukrainian,
                        Languages.urdu,
                        Languages.vietnamese,
                        Languages.chineseSimplified
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
