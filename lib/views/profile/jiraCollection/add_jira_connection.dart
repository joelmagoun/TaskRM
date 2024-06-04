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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddJiraConnectionBottomSheet extends StatefulWidget {
  final String taskType;

  const AddJiraConnectionBottomSheet({
    Key? key,
    required this.taskType,
  }) : super(key: key);

  @override
  State<AddJiraConnectionBottomSheet> createState() =>
      _AddJiraConnectionBottomSheetState();
}

class _AddJiraConnectionBottomSheetState
    extends State<AddJiraConnectionBottomSheet> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _apiController = TextEditingController();
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
        child: Consumer<ProfileProvider>(builder: (_, profileState, child) {
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
                  'Jira ',
                  style: tTextStyle500.copyWith(
                      fontSize: 14, color: secondaryColor),
                )
              ],
            ),
            Text(
              AppLocalizations.of(context)!.addconnection,
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
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildField(
              title: AppLocalizations.of(context)!.username,
              controller: _userNameController,
              hintText: 'ex. sarasmith5498'),
          primaryVerticalSpace,
          _buildField(
              title: AppLocalizations.of(context)!.url,
              controller: _urlController,
              hintText:
              'ex. sarasmith.atlassian.net'),
          primaryVerticalSpace,
          _buildField(
              title: AppLocalizations.of(context)!.apikey,
              controller: _apiController,
              hintText: 'ex. B48N65'),
          const SizedBox(
            height: 32,
          ),
          PrimaryButton(
            onTap: () {
              late String taskType = '';
              if(widget.taskType == 'Work'){
                setState(() {
                  taskType = '1';
                });
              }else if(widget.taskType == 'Personal'){
                setState(() {
                  taskType = '2';
                });
              }else if(widget.taskType == 'Self'){
                setState(() {
                  taskType = '3';
                });
              }
              profileState.addJiraConnection(
                  taskType, _userNameController.text,
                  _apiController.text, _urlController.text,
                  context);
            },
            buttonTitle: AppLocalizations.of(context)!.add,
            buttonColor:
            !isData ? primaryLight : primaryColor,
            isLoading: profileState.isJiraAdding,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildField({required String title,
    required TextEditingController controller,
    required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: tTextStyle500.copyWith(fontSize: 20, color: textPrimaryColor),
        ),
        TextFormField(
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
        )
      ],
    );
  }

}
