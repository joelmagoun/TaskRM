import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../utils/color.dart';
import '../../../utils/constant/constant.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';

class PhoneInputField extends StatelessWidget {
  final String title;
  final String name;
  final String? hintText;

  const PhoneInputField(
      {Key? key, required this.title, required this.name, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      autofocus: false,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: assColor,
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        hintStyle: hintTextStyle,
        focusedBorder: AppConstant.focusOutLineBorder,
        enabledBorder: AppConstant.enableOutLineBorder,
        errorBorder: AppConstant.outlineErrorBorder,
        focusedErrorBorder: AppConstant.outlineErrorBorder,
        focusColor: primaryColor,
      ),
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }
}
