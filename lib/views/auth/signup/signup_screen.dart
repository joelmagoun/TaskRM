import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/widgets/components/buttons/primary_button.dart';
import '../../../utils/spacer.dart';
import '../../../widgets/components/inputFields/email_inputfield.dart';
import '../../../widgets/components/inputFields/password_inputfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _loginFormKey = GlobalKey<FormBuilderState>();
  late bool isLoading = false;

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
              sixteenVerticalSpace,
              FormBuilder(
                key: _loginFormKey,
                enabled: !isLoading,
                autovalidateMode: AutovalidateMode.disabled,
                onChanged: () {
                  _loginFormKey.currentState!.save();
                },
                child: Padding(
                  padding: EdgeInsets.all(16.0),
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
                      PrimaryButton(onTap: () {}, buttonTitle: 'Log in'),
                      const SizedBox(
                        height: 36,
                      ),
                      Text(
                        'Don’t have an account?',
                        style: tTextStyleRegular.copyWith(fontSize: 14),
                      ),
                      TextButton(
                          onPressed: () {},
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
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: textFieldFillColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Image.asset(usaFlag),
                eightHorizontalSpace,
                Text(
                  'English',
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
        )
      ],
    );
  }
}
