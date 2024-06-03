import 'package:TaskRM/providers/jira_provider.dart';
import 'package:TaskRM/views/tasks/taskDetails/jira/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';

class JiraInformationBottomSheet extends StatefulWidget {
  final String jiraIssueId;

  const JiraInformationBottomSheet({Key? key, required this.jiraIssueId})
      : super(key: key);

  @override
  State<JiraInformationBottomSheet> createState() =>
      _JiraInformationBottomSheetState();
}

class _JiraInformationBottomSheetState
    extends State<JiraInformationBottomSheet> {
  final TextEditingController _jiraIssueId = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  late bool isData = false;

  String formatUtcDateTime(DateTime utcDateTime) {
    final DateFormat formatter = DateFormat('d MMM, yyyy');
    return formatter.format(utcDateTime);
  }

  @override
  void initState() {
    final jiraState = Provider.of<JiraProvider>(context, listen: false);
    //jiraState.getJiraIssueInfo('TSKIMPL-16');
    jiraState.connectToJira(
        'taskrm.atlassian.net',
        'joel.magoun@gmail.com',
        'ATATT3xFfGF0JGcmfqC0J4eaK7qHm_DnRGX2Kldp1y7bCBw3LOOFBGZLKYZleqINq4u3ehh3TBACaZHhOfilTdQMViBcQjnfXhgE8G_LN7pfxIMnuYl6lSBjkulr844LsXO2YqdutLz6NT3_tYXt0TO2VKJihVQypv3Y7d5asb3tkyNvWg4RXt0=0BDDA307',
        'TSKIMPL-16');
    //jiraState.getProfileInfo('TSKIMPL-16');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.2,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: white),
        child: Consumer<JiraProvider>(builder: (_, jiraState, child) {
          return SingleChildScrollView(
            child: jiraState.isJiraInfoLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      eightVerticalSpace,
                      _header(),
                      const Divider(),
                      _infoBody(),
                      const Divider(),
                      _commentSection(),
                    ],
                  ),
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
              'Information',
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

  Widget _infoBody() {
    final jiraState = Provider.of<JiraProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _infoTile(summaryIcon, 'Summary', jiraState.summary, false),
          primaryVerticalSpace,
          _infoTile(flagIcon, 'Status', jiraState.status, false),
          primaryVerticalSpace,
          _infoTile(priorityIcon, 'Priority', jiraState.priority, false),
          primaryVerticalSpace,
          _infoTile(typeIcon, 'Type', jiraState.type, false),
          primaryVerticalSpace,
          _infoTile(
              descriptionIcon, 'Description', jiraState.description, false),
          primaryVerticalSpace,
          //formatUtcDateTime(DateTime.parse(jiraState.created))
          _infoTile(
              createdIcon,
              'Created',
              jiraState.created.isEmpty
                  ? ''
                  : formatUtcDateTime(DateTime.parse(jiraState.created)),
              false),
          primaryVerticalSpace,
          //formatUtcDateTime(DateTime.parse(jiraState.updated))
          _infoTile(
              updatedIcon,
              'Updated',
              jiraState.updated.isEmpty
                  ? jiraState.updated
                  : formatUtcDateTime(DateTime.parse(jiraState.updated)),
              false),
          primaryVerticalSpace,
        ],
      ),
    );
  }

  Widget _infoTile(String icon, String title, String content, bool isGoal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: tTextStyle500.copyWith(
                  fontSize: 14,
                  color: isGoal ? primaryColor : const Color(0xFFAAAAAA)),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              color: trans,
            ),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                content,
                style: tTextStyleRegular.copyWith(
                    fontSize: 16, color: textColorBold),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _commentSection() {
    final jiraState = Provider.of<JiraProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments',
            style:
                tTextStyle500.copyWith(color: textPrimaryColor, fontSize: 20),
          ),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  var item = jiraState.commentList[index];
                  return CommentTile(
                      imageUrl: item.imageUrl,
                      userName: item.name,
                      date: item.date,
                      comment: item.comment);
                },
                separatorBuilder: (_, index) => eightVerticalSpace,
                itemCount: jiraState.commentList.length),
          ),
          eightVerticalSpace,
          TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                filled: true,
                fillColor: white,
                contentPadding: const EdgeInsets.all(12),
                hintText: 'Add Comment',
                hintStyle: hintTextStyle,
                suffixIcon: IconButton(
                    onPressed: () async {
                      await jiraState
                          .addCommentToJira(
                              'TSKIMPL-16', _commentController.text)
                          .then((value) {
                        _commentController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      color: iconColor,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusColor: primaryColor,
              )),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
