import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.g.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/auth_provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import '../../../routes/routes.dart';
import '../../../utils/spacer.dart';
import '../../../widgets/components/inputFields/email_inputfield.dart';
import '../../../widgets/components/inputFields/password_inputfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormBuilderState>();
  late bool isLoading = false;
  late String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<AuthProvider>(
            builder: (_, _authState, child) {
              return Column(
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
                    'Log in',
                    style: tTextStyle500.copyWith(
                        fontSize: 24, color: textPrimaryColor),
                  ),
                  sixteenVerticalSpace,
                  FormBuilder(
                    key: _loginFormKey,
                    enabled: !isLoading,
                    autovalidateMode: AutovalidateMode.disabled,
                    onChanged: () {
                      _loginFormKey.currentState!.save();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: tTextStyleRegular.copyWith(
                                      fontSize: 12, color: textPrimaryColor),
                                )),
                          ),
                          eightVerticalSpace,
                          _languageField(),
                          primaryVerticalSpace,
                          PrimaryButton(
                              onTap: () async {
                                await _authState.login(
                                    _loginFormKey.currentState?.value['email'],
                                    _loginFormKey
                                        .currentState?.value['password'],
                                    context);
                              },
                              buttonTitle: 'Log in', isLoading: _authState.isLogin,),
                          const SizedBox(
                            height: 36,
                          ),
                          Text(
                            'Don’t have an account?',
                            style: tTextStyleRegular.copyWith(fontSize: 14),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.signUp);
                              },
                              child: Text(
                                'Sign up',
                                style: tTextStyle500.copyWith(
                                    fontSize: 16, color: primaryColor),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
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
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: textFieldFillColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Image.asset(_selectedLanguage == 'en'
                    ? usaFlag
                    : _selectedLanguage == 'is'
                    ? icelandFlag
                    : _selectedLanguage == 'de'
                    ? germanyFlag
                    : norwegianFlag, height: 32, width: 32,),
                sixteenHorizontalSpace,
                Expanded(
                  child: LanguagePickerDropdown(
                      initialValue: Languages.english,
                      languages: [
                        Languages.english,
                        Languages.icelandic,
                        Languages.german,
                        Languages.norwegian
                      ],
                      onValuePicked: (language) {
                        setState(() {
                          _selectedLanguage = language.isoCode;
                        });
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
