import 'package:flutter/material.dart';
import 'package:gesture_password_widget/widget/gesture_password_widget.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/auth_provider.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/custom_snack.dart';
import '../../../../utils/spacer.dart';

class EncryptionBottomSheet extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String language;

  const EncryptionBottomSheet({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.language,
  }) : super(key: key);

  @override
  State<EncryptionBottomSheet> createState() => _EncryptionBottomSheetState();
}

class _EncryptionBottomSheetState extends State<EncryptionBottomSheet> {
  late String _patternResult = '';

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
        child: Consumer<AuthProvider>(builder: (_, _authState, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              eightVerticalSpace,
              _header(),
              eightVerticalSpace,
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This pattern enables you to recall your encryption key in case of phone loss or data deletion.',
                      textAlign: TextAlign.center,
                      style: tTextStyleRegular.copyWith(fontSize: 14),
                    ),
                    primaryVerticalSpace,
                    GesturePasswordWidget(
                      normalItem: _normalItem(),
                      selectedItem: _selectedItem(),
                      lineColor: primaryColor,
                      errorLineColor: Colors.red,
                      singleLineCount: 3,
                      identifySize: 80.0,
                      minLength: 4,
                      //answer: correctAnswerList,
                      color: trans,
                      onComplete: (data) {
                        _patternResult = data.join('');
                      },
                    ),
                    primaryVerticalSpace,
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _patternResult = '';
                          });
                        },
                        child: Text(
                          'Reset',
                          style: tTextStyle600.copyWith(
                              fontSize: 16,
                              color: primaryColor),
                        )),
                    sixteenVerticalSpace,
                    PrimaryButton(
                      onTap: () async {
                        if (_patternResult != '') {
                          var response =  await _authState.signUp(
                              widget.email,
                              widget.password,
                              widget.name,
                              _patternResult,
                              widget.language,
                              '',
                              '',
                              '',
                              context);

                          if(response == true){
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, Routes.login);
                          }

                        }else{
                          CustomSnack.warningSnack('You must enter a pattern password!', context);
                        }

                      },
                      buttonTitle: 'Submit',
                      buttonColor: primaryColor,
                      isLoading: _authState.isAccountCreating,
                    ),
                    primaryVerticalSpace,
                  ],
                ),
              )
            ],
          );
        },),
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
        Column(
          children: [
            Text(
              '“Encryption key”',
              style: tTextStyle500.copyWith(fontSize: 20, color: black),
            ),
            Text(
              'Pattern',
              style: tTextStyle500.copyWith(fontSize: 20, color: black),
            ),
          ],
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

  Widget _normalItem() {
    return const CircleAvatar(
      radius: 40,
      backgroundColor: Color(0xFFF0F1F8),
      child: CircleAvatar(
        radius: 4,
        backgroundColor: primaryColor,
      ),
    );
  }

  Widget _selectedItem() {
    return const CircleAvatar(
      radius: 40,
      backgroundColor: Color(0xFFF0F1F8),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: primaryLight,
        child: CircleAvatar(
          radius: 4,
          backgroundColor: primaryColor,
        ),
      ),
    );
  }

}
