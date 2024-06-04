import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/profile_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/profile/jiraCollection/add_jira_connection.dart';
import 'package:TaskRM/views/profile/jiraCollection/jira_connection_card.dart';
import 'package:TaskRM/widgets/empty_widget.dart';
import '../../../utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JiraConnectionScreen extends StatefulWidget {
  const JiraConnectionScreen({Key? key}) : super(key: key);

  @override
  State<JiraConnectionScreen> createState() => _JiraConnectionScreenState();
}

class _JiraConnectionScreenState extends State<JiraConnectionScreen> {
  late bool isData = false;

  @override
  void initState() {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    profileState.getJiraConnections(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, profileState, child) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  AppLocalizations.of(context)!.connections,
                  style: tTextStyle500.copyWith(
                      fontSize: 20, color: textPrimaryColor),
                ),
              ],
            ),
            bottom: TabBar(
                indicatorColor: primaryColor,
                labelStyle: tTextStyle500.copyWith(
                    color: textPrimaryColor, fontSize: 16),
                unselectedLabelStyle:
                    tTextStyle500.copyWith(color: iconColor, fontSize: 16),
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.work,
                  ),
                  Tab(
                    text: 'Personal',
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.self,
                  )
                ]),
          ),
          body: profileState.isJiraLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TabBarView(
                      children: [_workBody(), _personalBody(), _selfBody()]),
                ),
        ),
      );
    });
  }

  Widget _workBody() {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    if (profileState.workModel.taskType.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmptyWidget(
                icon: emptyJira,
                title: 'Add Jira link',
                subTitle:
                    'All tasks of the type “Work” will be linked to this Jira address.'),
            sixteenVerticalSpace,
            IconButton(
              onPressed: () {
                CustomDialog.bottomSheet(
                    context,
                    const AddJiraConnectionBottomSheet(
                      taskType: 'Work',
                    ));
              },
              icon: const Icon(
                Icons.add_circle_rounded,
              ),
              color: primaryColor,
              iconSize: 64,
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            'All tasks of the type “Work” are linked to this Jira addresses.',
            style: tTextStyleRegular.copyWith(
                fontSize: 14, color: textPrimaryColor),
          ),
          sixteenVerticalSpace,
          JiraConnectionCard(
            docId: profileState.workModel.docId,
              userId: profileState.workModel.userId,
              taskType: profileState.workModel.taskType,
              userName: profileState.workModel.userName,
              url: profileState.workModel.url,
              apiKey: profileState.workModel.apiKey)
        ],
      );
    }
  }

  Widget _personalBody() {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    if (profileState.personalModel.taskType.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmptyWidget(
                icon: emptyJira,
                title: 'Add Jira link',
                subTitle:
                    'All tasks of the type “Personal” will be linked to this Jira address.'),
            sixteenVerticalSpace,
            IconButton(
              onPressed: () {
                CustomDialog.bottomSheet(
                    context,
                    const AddJiraConnectionBottomSheet(
                      taskType: 'Personal',
                    ));
              },
              icon: const Icon(
                Icons.add_circle_rounded,
              ),
              color: primaryColor,
              iconSize: 64,
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            'All tasks of the type “Personal” are linked to this Jira addresses.',
            style: tTextStyleRegular.copyWith(
                fontSize: 14, color: textPrimaryColor),
          ),
          sixteenVerticalSpace,
          JiraConnectionCard(
              docId: profileState.personalModel.docId,
              userId: profileState.personalModel.userId,
              taskType: profileState.personalModel.taskType,
              userName: profileState.personalModel.userName,
              url: profileState.personalModel.url,
              apiKey: profileState.personalModel.apiKey)
        ],
      );
    }
  }

  Widget _selfBody() {
    final profileState = Provider.of<ProfileProvider>(context, listen: false);
    if (profileState.selfModel.taskType.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmptyWidget(
                icon: emptyJira,
                title: 'Add Jira link',
                subTitle:
                    'All tasks of the type “Self” will be linked to this Jira address.'),
            sixteenVerticalSpace,
            IconButton(
              onPressed: () {
                CustomDialog.bottomSheet(
                    context,
                    const AddJiraConnectionBottomSheet(
                      taskType: 'Self',
                    ));
              },
              icon: const Icon(
                Icons.add_circle_rounded,
              ),
              color: primaryColor,
              iconSize: 64,
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            'All tasks of the type “Self” are linked to this Jira addresses.',
            style: tTextStyleRegular.copyWith(
                fontSize: 14, color: textPrimaryColor),
          ),
          sixteenVerticalSpace,
          JiraConnectionCard(
              docId: profileState.selfModel.docId,
              userId: profileState.selfModel.userId,
              taskType: profileState.selfModel.taskType,
              userName: profileState.selfModel.userName,
              url: profileState.selfModel.url,
              apiKey: profileState.selfModel.apiKey)
        ],
      );
    }
  }
}
