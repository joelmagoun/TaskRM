import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/models/jira_connection_model.dart';
import 'package:TaskRM/providers/profile_provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/newTask/add_new_task_bottomsheet.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../routes/routes.dart';
import '../../../utils/constant/constant.dart';

class EditJiraConnectionBottomSheet extends StatefulWidget {
  final JiraConnectionModel jiraModel;

  const EditJiraConnectionBottomSheet({
    Key? key,
    required this.jiraModel,
  }) : super(key: key);

  @override
  State<EditJiraConnectionBottomSheet> createState() =>
      _EditJiraConnectionBottomSheetState();
}

class _EditJiraConnectionBottomSheetState
    extends State<EditJiraConnectionBottomSheet> {
  late TextEditingController _userNameController;
  late TextEditingController _urlController;
  late TextEditingController _apiController;
  late bool isData = false;

  @override
  void initState() {
     _userNameController = TextEditingController(text: widget.jiraModel.userName);
     _urlController = TextEditingController(text: widget.jiraModel.url);
     _apiController = TextEditingController(text: widget.jiraModel.apiKey);
    super.initState();
  }

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
                  'Jira',
                  style: tTextStyle500.copyWith(
                      fontSize: 14, color: secondaryColor),
                )
              ],
            ),
            Text(
              'Edit connection',
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
              title: 'Username',
              controller: _userNameController,
              hintText: 'ex. sarasmith5498'),
          primaryVerticalSpace,
          _buildField(
              title: 'URL',
              controller: _urlController,
              hintText:
                  'ex. https://sarasmith.atlassian.net/browse/Personalprojectstasks9784'),
          primaryVerticalSpace,
          _buildField(
              title: 'API key',
              controller: _apiController,
              hintText: 'ex. B48N65'),
          const SizedBox(
            height: 32,
          ),
          PrimaryButton(
            onTap: () {
              profileState.jiraConnectionUpdating(
                  widget.jiraModel.docId,
                  widget.jiraModel.taskType,
                  _userNameController.text,
                  _apiController.text,
                  _urlController.text,
                  context);
            },
            buttonTitle: 'Save',
            buttonColor: !isData ? primaryLight : primaryColor,
            isLoading: profileState.isJiraUpdating,
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
