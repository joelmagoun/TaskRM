import 'package:TaskRM/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/profile_provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../utils/constant/constant.dart';

class LinkJiraBottomSheet extends StatefulWidget {
  const LinkJiraBottomSheet({Key? key}) : super(key: key);

  @override
  State<LinkJiraBottomSheet> createState() => _LinkJiraBottomSheetState();
}

class _LinkJiraBottomSheetState extends State<LinkJiraBottomSheet> {
  final TextEditingController _jiraIssueId = TextEditingController();
  late bool isData = false;

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
        child: Consumer<TaskProvider>(builder: (_, taskState, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              eightVerticalSpace,
              _header(),
              const Divider(),
              eightVerticalSpace,
              _buildForm(),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset(jiraIcon),
                eightHorizontalSpace,
                Text(
                  'Jira',
                  style: tTextStyle500.copyWith(
                      fontSize: 14, color: secondaryColor),
                )
              ],
            ),
            Text(
              'Add Issue',
              style:
                  tTextStyle500.copyWith(fontSize: 20, color: textPrimaryColor),
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

  Widget _buildForm() {
    final taskState = Provider.of<TaskProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildField(
              title: 'Username',
              controller: _jiraIssueId,
              hintText: 'PROJ-1234'),
          const SizedBox(
            height: 32,
          ),
          PrimaryButton(
            onTap: () {
              taskState.setJiraId(_jiraIssueId.text, true, context);
            },
            buttonTitle: 'Submit',
            buttonColor: !isData ? primaryLight : primaryColor,
            // isLoading: profileState.isJiraAdding,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      {required String title,
      required TextEditingController controller,
      required String hintText}) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      cursorColor: primaryColor,
      onChanged: (value) {
        setState(() {
          isData = true;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.all(12),
        hintText: hintText,
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
    );
  }
}
