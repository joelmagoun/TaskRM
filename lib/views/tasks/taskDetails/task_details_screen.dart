import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../models/task.dart';
import '../../../utils/assets_path.dart';

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
                  'Task',
                  style: tTextStyleRegular.copyWith(fontSize: 16, color: black),
                ),
                Text(
                  widget.task.title,
                  maxLines: 2,
                  style: tTextStyleRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
            actions: [SvgPicture.asset(menuIcon), sixteenHorizontalSpace],
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
                        _infoTile(typeIcon, 'Type', widget.task.type, false),
                        primaryVerticalSpace,
                        _infoTile(priorityIcon, 'Priority',
                            widget.task.priority, false),
                        primaryVerticalSpace,
                        _infoTile(timeFrameIcon, 'Timeframe',
                            widget.task.timeframe, false),
                        primaryVerticalSpace,
                        _infoTile(descriptionIcon, 'Description',
                            widget.task.description, false),
                        primaryVerticalSpace,
                        _infoTile(goalIcon, 'Goal', widget.task.goal, true),
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
                  fontSize: 14, color: isGoal ? primaryColor : const Color(0xFFAAAAAA)),
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
            _bottomButton(clearIcon, 'Remove from\nToday’s Tasks', false),
            _bottomButton(addTimeIcon, 'Add Time', false),
            _bottomButton(checkIcon, 'Complete Task', true),
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
