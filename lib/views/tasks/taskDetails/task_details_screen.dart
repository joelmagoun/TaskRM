import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/views/tasks/taskDetails/editTask/edit_task_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../models/task.dart';
import '../../../utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late int selectedTask = -1;
  late bool isSelected = false;

  /// for move to today list ///
  late String selectedTaskId = '';
  late String selectedTaskTitle = '';
  late String selectedTaskType = '';
  late String selectedTaskPriority = '';
  late String selectedTaskDescription = '';
  late String selectedTaskGoal = '';
  late String selectedTaskCreatedAt = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (_, _taskState, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: false,
            shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.task,
                  style: tTextStyleRegular.copyWith(fontSize: 16, color: black),
                ),
                Text(
                  widget.task.title,
                  maxLines: 2,
                  style: tTextStyleRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
            actions: [
              PopupMenuButton(
                icon: SvgPicture.asset(menuIcon),
                color: white,
                onSelected: (value) {
                  // your logic
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        CustomDialog.bottomSheet(
                            context,
                            EditTaskBottomSheet(
                              task: widget.task,
                            ));
                      },
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit_outlined),
                          eightHorizontalSpace,
                          Text(AppLocalizations.of(context)!.edit),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: '/hello',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_outline,
                            color: red,
                          ),
                          eightHorizontalSpace,
                          Text(
                            AppLocalizations.of(context)!.delete,
                            style: tTextStyle600.copyWith(color: red),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
              sixteenHorizontalSpace,
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _infoTile(typeIcon, AppLocalizations.of(context)!.type, widget.task.type, false),
                        primaryVerticalSpace,
                        _infoTile(priorityIcon, AppLocalizations.of(context)!.priority,
                            widget.task.priority, false),
                        primaryVerticalSpace,
                        _infoTile(timeFrameIcon, AppLocalizations.of(context)!.timeframe,
                            widget.task.timeframe, false),
                        primaryVerticalSpace,
                        _infoTile(descriptionIcon, AppLocalizations.of(context)!.description,
                            widget.task.description, false),
                        primaryVerticalSpace,
                        _infoTile(goalIcon, AppLocalizations.of(context)!.goal, widget.task.goal, true),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _bottomSheet()
          ],
        ),
      );
    });
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

  Widget _bottomSheet() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: borderColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bottomButton(clearIcon, AppLocalizations.of(context)!.removefromtodaystasks, false),
            _bottomButton(addTimeIcon, AppLocalizations.of(context)!.addtime, false),
            _bottomButton(checkIcon, AppLocalizations.of(context)!.completetask, true),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(String icon, String title, bool isComplete) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        eightVerticalSpace,
        Text(
          title,
          style: tTextStyle500.copyWith(
              fontSize: 14, color: isComplete ? primaryColor : secondaryColor),
        )
      ],
    );
  }
}
