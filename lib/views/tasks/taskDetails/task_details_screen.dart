import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../models/task.dart';
import '../../../utils/assets_path.dart';
import 'package:TaskRM/widgets/dialogs/add_time_dialog.dart';
import 'package:TaskRM/views/tasks/task_form_bottomsheet.dart';
import 'package:TaskRM/utils/custom_dialog.dart';

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
                  widget.task.title!,
                  maxLines: 2,
                  style: tTextStyleRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
            actions: [
              PopupMenuButton<String>(
                icon: SvgPicture.asset(menuIcon),
                offset: const Offset(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(Icons.edit_outlined, color: textPrimaryColor, size: 20),
                        sixteenHorizontalSpace,
                        Text(
                          'Edit',
                          style: tTextStyle500.copyWith(
                            fontSize: 14,
                            color: textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                        sixteenHorizontalSpace,
                        Text(
                          'Delete',
                          style: tTextStyle500.copyWith(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      CustomDialog.bottomSheet(
                        context,
                        TaskFormBottomSheet(task: widget.task),
                      );
                      break;
                    case 'delete':
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFF5F5F5),
                                    ),
                                    child: const Icon(
                                      Icons.delete_outline,
                                      color: textPrimaryColor,
                                      size: 24,
                                    ),
                                  ),
                                  sixteenVerticalSpace,
                                  Text(
                                    'Delete task',
                                    style: tTextStyle500.copyWith(
                                      fontSize: 20,
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                  eightVerticalSpace,
                                  Text(
                                    'Deleted items will be forever lost.\nAre you sure?',
                                    textAlign: TextAlign.center,
                                    style: tTextStyleRegular.copyWith(
                                      fontSize: 14,
                                      color: textSecondaryColor,
                                    ),
                                  ),
                                  twentyFourVerticalSpace,
                                  InkWell(
                                    onTap: () async {
                                      final taskProvider = Provider.of<TaskProvider>(
                                        context, 
                                        listen: false
                                      );
                                      
                                      try {
                                        await taskProvider.deleteTask(widget.task.id.toString());
                                        if (mounted) {
                                          Navigator.pop(context); // Close dialog
                                          Navigator.pop(context); // Return to previous screen
                                        }
                                      } catch (e) {
                                        if (mounted) {
                                          Navigator.pop(context); // Close dialog
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Failed to delete task'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: borderColor),
                                          bottom: BorderSide(color: borderColor),
                                        ),
                                      ),
                                      child: Text(
                                        'Delete',
                                        textAlign: TextAlign.center,
                                        style: tTextStyle500.copyWith(
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: Text(
                                        'Cancel',
                                        textAlign: TextAlign.center,
                                        style: tTextStyle500.copyWith(
                                          fontSize: 16,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      break;
                  }
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
                        _infoTile(typeIcon, 'Type', widget.task.type!, false),
                        primaryVerticalSpace,
                        _infoTile(priorityIcon, 'Priority',
                            widget.task.priority!, false),
                        primaryVerticalSpace,
                        _infoTile(timeFrameIcon, 'Timeframe',
                            widget.task.timeframe!, false),
                        primaryVerticalSpace,
                        _infoTile(descriptionIcon, 'Description',
                            widget.task.description!, false),
                        primaryVerticalSpace,
                        _infoTile(goalIcon, 'Goal', widget.task.goal!, true),
                        primaryVerticalSpace,
                        _infoTile(scheduleIcon, 'Time spent', '', false),
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
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 4),
            Text(
              title,
              style: tTextStyle500.copyWith(
                fontSize: 14,
                color: isGoal ? primaryColor : const Color(0xFFAAAAAA),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(icon, color: trans),
            const SizedBox(width: 4),
            if (title == 'Time spent')
              FutureBuilder<String>(
                future: taskProvider.getTaskTimeSpent(widget.task.id.toString()),
                builder: (context, snapshot) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      snapshot.data ?? 'Loading...',
                      style: tTextStyleRegular.copyWith(
                        fontSize: 16,
                        color: textColorBold,
                      ),
                    ),
                  );
                },
              )
            else
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  content,
                  style: tTextStyleRegular.copyWith(
                    fontSize: 16,
                    color: textColorBold,
                  ),
                ),
              ),
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
    final taskState = Provider.of<TaskProvider>(context, listen: false);
    
    return InkWell(
      onTap: () {
        if (isComplete) {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Complete Task'),
              content: Text('Are you sure you want to mark this task as complete?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    taskState.toggleTaskComplete(
                      widget.task.id.toString(),
                      (widget.task.isCompleted as int?) == 1,
                      context,
                    );
                    Navigator.pop(context); // Return to previous screen
                  },
                  child: Text('Complete'),
                ),
              ],
            ),
          );
        } else if (title.contains('Add Time')) { // Check if it's the Add Time button
          // Show add time dialog
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddTimeDialog(
              isGoal: false,
              itemId: widget.task.id.toString(),
            ),
          );
        }
      },
      child: Column(
        children: [
          taskState.isCompletingTask && isComplete
              ? const CircularProgressIndicator(color: primaryColor)
              : SvgPicture.asset(icon),
          eightVerticalSpace,
          Text(
            title,
            style: tTextStyle500.copyWith(
                fontSize: 14, 
                color: isComplete ? primaryColor : secondaryColor),
          )
        ],
      ),
    );
  }
}
