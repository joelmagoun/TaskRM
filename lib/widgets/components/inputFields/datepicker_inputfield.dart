// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:intl/intl.dart';
// import '../../../utils/color.dart';
// import '../../../utils/constant/constant.dart';
// import '../../../utils/typograpgy.dart';
//
// class DatePickerTextField extends StatelessWidget {
//   final String name;
//   final String? title;
//   final  String? hintText;
//   final VoidCallback? onTap;
//
//   const DatePickerTextField(
//       {Key? key,
//         this.title,
//         required this.name,
//         this.onTap,
//         this.hintText})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title!,
//           style: subtitle2,
//         ),
//         const SizedBox(
//           height: 12,
//         ),
//         FormBuilderDateTimePicker(
//           name: name,
//           enableInteractiveSelection: false,
//           initialEntryMode: DatePickerEntryMode.calendar,
//           inputType: InputType.date,
//           lastDate: DateTime.now(),
//           format: DateFormat('yyyy-MM-dd'),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: white,
//             contentPadding: const EdgeInsets.all(16),
//             hintText: hintText,
//             hintStyle: hintTextStyle,
//             // prefixIcon: Padding(
//             //   padding: const EdgeInsets.all(16.0),
//             //   child: SvgPicture.asset(
//             //     prefixIconPath!,color: iconColor,
//             //   ),
//             //),
//             // suffixIcon: isSuffixIcon == false
//             //     ? const SizedBox.shrink()
//             //     : Padding(
//             //   padding:   EdgeInsets.all(16.0),
//             //   child: SvgPicture.asset(suffixIconPath!),
//             // ),
//             focusedBorder: AppConstant.outLineBorder,
//             enabledBorder: AppConstant.outLineBorder,
//             errorBorder: AppConstant.outlineErrorBorder,
//             focusedErrorBorder: AppConstant.outlineErrorBorder,
//             focusColor: primaryColor,
//           ),
//         ),
//       ],
//     );
//   }
// }