import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:TaskRM/models/jira_connection_model.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/profile/jiraCollection/edit_jira_connection.dart';
import 'package:TaskRM/views/profile/jiraCollection/jira_delete_dialog.dart';
import '../../../utils/assets_path.dart';

class JiraConnectionCard extends StatelessWidget {
  final String docId;
  final String userId;
  final String taskType;
  final String userName;
  final String url;
  final String apiKey;

  const JiraConnectionCard({Key? key,
    required this.docId,
    required this.userId,
    required this.taskType,
    required this.userName,
    required this.url,
    required this.apiKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: textFieldFillColor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            infoTile(Icons.person_2_outlined, 'Username', userName, context),
            sixteenVerticalSpace,
            infoTile(Icons.link, 'URL', url, context),
            sixteenVerticalSpace,
            infoTile(Icons.key, 'API key', apiKey, context),
            sixteenVerticalSpace,
            const Divider(),
            eightVerticalSpace,
            _buildDeleteAndChangeButtons(context)
          ],
        ),
      ),
    );
  }

  Widget infoTile(IconData icon, String title, String info,
      BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: iconColor.withOpacity(0.7),
            ),
            const SizedBox(width: 2),
            Text(
              title,
              style: tTextStyle500.copyWith(fontSize: 14, color: iconColor),
            )
          ],
        ),
        Row(
          children: [
            Icon(
              icon,
              color: trans,
            ),
            const SizedBox(
              width: 2,
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5,
              child: Text(
                info,
                style: tTextStyle500.copyWith(
                    fontSize: 16, color: textPrimaryColor),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildDeleteAndChangeButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: (){
              CustomDialog.dialogBuilder(context, JiraDeleteDialog(docId: docId,));
            },
            child: SvgPicture.asset(jiraDelete)),
        sixteenHorizontalSpace,
        InkWell(
            onTap: () {
              CustomDialog.bottomSheet(
                  context, EditJiraConnectionBottomSheet(
                jiraModel: JiraConnectionModel(
                  docId: docId,
                  userId: userId,
                  taskType: taskType,
                  userName: userName,
                  apiKey: apiKey,
                  url: url,),));
            },
            child: SvgPicture.asset(jiraEdit)),
      ],
    );
  }
}
