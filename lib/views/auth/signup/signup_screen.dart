//import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/widgets/components/buttons/primary_button.dart';
import 'package:task_rm/widgets/components/inputFields/common_textfield.dart';
import '../../../utils/spacer.dart';
import '../../../widgets/components/inputFields/email_inputfield.dart';
import '../../../widgets/components/inputFields/password_inputfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormBuilderState>();
  late bool isLoading = false;
  late String _selectedCountryFlag = '';
  late String _selectedCountry = 'English';
  late String imageUrl = dummyProfileImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 295,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(topper), fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Create Account',
                style:
                tTextStyle500.copyWith(fontSize: 24, color: textPrimaryColor),
              ),
              primaryVerticalSpace,
              _profilePicture(),
              sixteenVerticalSpace,
              FormBuilder(
                key: _signUpFormKey,
                enabled: !isLoading,
                autovalidateMode: AutovalidateMode.disabled,
                onChanged: () {
                  _signUpFormKey.currentState!.save();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      const CommonTextField( name: 'name', hintText: 'Name'),
                      sixteenVerticalSpace,
                      const EmailInputField(
                        name: 'email',
                        hintText: 'Email',
                      ),
                      sixteenVerticalSpace,
                      const PasswordInputField(
                        title: 'Password',
                        name: 'password',
                        hintText: 'Password',
                      ),
                      sixteenVerticalSpace,
                      _languageField(),
                      primaryVerticalSpace,
                      PrimaryButton(onTap: () {}, buttonTitle: 'Sign up'),
                      const SizedBox(
                        height: 36,
                      ),
                      Text(
                        'Already have an account?',
                        style: tTextStyleRegular.copyWith(fontSize: 14),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Log in',
                            style: tTextStyle500.copyWith(
                                fontSize: 16, color: primaryColor),
                          )),
                      primaryVerticalSpace
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _languageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: tTextStyle500.copyWith(
              fontSize: 14, color: const Color(0xFF8085C2)),
        ),
        const SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: false,
              onSelect: (Country country) {
                setState(() {
                  _selectedCountry = country.name;
                  _selectedCountryFlag = country.flagEmoji;
                });
              },
            );
          },
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: textFieldFillColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _selectedCountryFlag.isEmpty
                      ? Image.asset(usaFlag)
                      : Text(
                    _selectedCountryFlag,
                    style: const TextStyle(fontSize: 28),
                  ),
                  eightHorizontalSpace,
                  Text(
                    _selectedCountry,
                    style: tTextStyleRegular.copyWith(
                        fontSize: 16, color: textPrimaryColor),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Color(0xFF555DAD),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _profilePicture() {
    return Stack(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        imageUrl.isEmpty ? Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
             border: Border.all(color: assColor, width: 5)
          ),
          child: const Icon(Icons.person_outline, color: assColor, size: 50,),
        ) : Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
          ),
        ),
        Positioned(
            top: 90,
            left: 90,
            child: InkWell(
              onTap: (){
                  _showAlertDialog(context);
              },
                child: SvgPicture.asset(imageUrl.isEmpty ? addIcon : editIcon)))
      ],
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Select Image',
              style: subtitle2,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Gallery',
                  style: subtitle2.copyWith(color: black),
                ),
                onPressed: () async {
                  // await _profileState.pickImage(
                  //     ImageSource.gallery,
                  //     _profileState
                  //         .userProfileFormKey.currentState?.value['name'] ??
                  //         _profileState.name,
                  //     selectedCountry == '' ? _profileState.country : selectedCountry,
                  //     _phone.dialCode! ?? '',
                  //     _phoneNumberController.text ?? '',
                  //     _profileState
                  //         .userProfileFormKey.currentState?.value['gender'] ??
                  //         _profileState.gender,
                  //     _profileState
                  //         .userProfileFormKey.currentState?.value['email'] ?? _profileState.userEmail
                  // );
                  // Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'Camera',
                  style: subtitle2.copyWith(color: black),
                ),
                onPressed: () async {
                  // await _profileState.pickImage(
                  //     ImageSource.gallery,
                  //     _profileState
                  //         .userProfileFormKey.currentState?.value['name'] ??
                  //         '',
                  //     selectedCountry == '' ? _profileState.country : selectedCountry,
                  //     _phone.dialCode! ?? '',
                  //     _phoneNumberController.text ?? '',
                  //     _profileState
                  //         .userProfileFormKey.currentState?.value['gender'] ??
                  //         _profileState.gender,
                  //     _profileState.userProfileFormKey.currentState
                  //         ?.value['email'] ??
                  //         '');
                  // Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'Back',
                  style: subtitle2,
                ),
                onPressed: () {
                 // Get.back();
                },
              ),
            ],
          );
        });
  }

}
