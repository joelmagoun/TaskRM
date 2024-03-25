import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/task_provider.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import '../../../utils/assets_path.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({Key? key}) : super(key: key);

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
                  'Task',
                  style: tTextStyleRegular.copyWith(fontSize: 16, color: black),
                ),
                Text(
                  'Task title',
                  maxLines: 2,
                  style: tTextStyleRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
            actions: [SvgPicture.asset(menuIcon), sixteenHorizontalSpace],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _infoTile(typeIcon, 'Type', 'type content'),
              primaryVerticalSpace,
              _infoTile(priorityIcon, 'Priority', 'priority content'),
              primaryVerticalSpace,
              _infoTile(timeFrameIcon, 'Timeframe', 'timeFrame content'),
              primaryVerticalSpace,
              _infoTile(descriptionIcon, 'Description', 'description content'),
              primaryVerticalSpace,
              _infoTile(goalIcon, 'Goal', 'goal content'),
              primaryVerticalSpace,
            ],
          ),
        ),
      );
    });
  }

  Widget _bottomSheet(BuildContext context) {
    final _taskState = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          color: white,
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF2A2A2A).withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -2))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isSelected = false;
                  selectedTask = -1;
                });
              },
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor)),
                child: const Icon(
                  Icons.clear,
                  color: iconColor,
                ),
              ),
            ),
            eightHorizontalSpace,
            Expanded(
              child: InkWell(
                onTap: () async {
                  await _taskState.moveToTodayTaskList(
                      selectedTaskId,
                      selectedTaskTitle,
                      selectedTaskType,
                      selectedTaskPriority,
                      selectedTaskDescription,
                      selectedTaskGoal,
                      selectedTaskCreatedAt,
                      context);
                },
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor,
                  ),
                  child: _taskState.isMoving
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: white,
                        ))
                      : Text(
                          'Move to “Today’s tasks”',
                          style: tTextStyle600.copyWith(
                              fontSize: 16, color: white),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String icon, String title, String content) {
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
                  fontSize: 14, color: const Color(0xFFAAAAAA)),
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
            Text(
              content,
              style: tTextStyleRegular.copyWith(
                  fontSize: 16, color: textColorBold),
            )
          ],
        ),
      ],
    );
  }
}
