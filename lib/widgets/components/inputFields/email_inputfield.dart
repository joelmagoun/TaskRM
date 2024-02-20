import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../utils/color.dart';
import '../../../utils/constant/constant.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';


class  EmailInputField extends StatelessWidget {
  final String name;
  final String? hintText;

  const EmailInputField({
    Key? key,
    required this.name,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      autofocus: false,
      cursorColor: secondaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: textFieldFillColor,
        contentPadding: const EdgeInsets.all(12),
        hintText: hintText,
        hintStyle: hintTextStyle,
        focusedBorder: AppConstant.focusOutLineBorder,
        enabledBorder: AppConstant.enableOutLineBorder,
        errorBorder: AppConstant.outlineErrorBorder,
        focusedErrorBorder: AppConstant.outlineErrorBorder,
        focusColor: secondaryColor,
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.email(),
        FormBuilderValidators.required(),
      ]),
    );
  }
}
