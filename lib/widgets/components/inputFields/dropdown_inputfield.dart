import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../utils/color.dart';
import '../../../utils/constant/constant.dart';
import '../../../utils/typograpgy.dart';

class DropdownTextField extends StatelessWidget {
  final String name;
  final String hintText;
  final bool isSuffix;
  final String unit;
  final List<DropdownMenuItem<String>> itemList;
  final Function(dynamic val)? transformer;

  const DropdownTextField(
      {Key? key,
      this.hintText = '',
      this.isSuffix = false,
        this.unit = '',
      required this.itemList,
      required this.name,
      this.transformer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: name,
      iconDisabledColor: isSuffix ? Colors.transparent : secondaryColor,
      iconEnabledColor: isSuffix ? Colors.transparent : secondaryColor,
     // icon: const Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        filled: true,
        fillColor: assColor,
        contentPadding: const EdgeInsets.all(16.0),
        hintText: hintText,
        hintStyle: hintTextStyle,
       // prefixIcon: const Icon(Icons.add, color: Colors.transparent,),
        suffixIcon: isSuffix ? Container(
          height: 55,
          width: 80,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: assColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(unit, style: subtitle2.copyWith(color: black),),
            const Icon(Icons.keyboard_arrow_down)
          ],),
        ) : null,
       // icon: const Icon(Icons.add, color: Colors.transparent,),
        focusedBorder: AppConstant.focusOutLineBorder,
        enabledBorder: AppConstant.enableOutLineBorder,
        errorBorder: AppConstant.outlineErrorBorder,
        focusedErrorBorder: AppConstant.outlineErrorBorder,
        focusColor: primaryColor,
      ),
      validator:
          FormBuilderValidators.compose([FormBuilderValidators.required()]),
      items: itemList,
      valueTransformer: (val) => val?.toString(),
      onChanged: transformer,
      // valueTransformer: transformer,
    );
  }
}
