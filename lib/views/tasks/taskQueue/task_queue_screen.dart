import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/taskQueue/task_queue_filter_bottom_sheet.dart';
import 'package:TaskRM/widgets/components/task_tile.dart';
import 'package:TaskRM/widgets/empty_widget.dart';
import '../../../utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskQueueScreen extends StatefulWidget {
  const TaskQueueScreen({Key? key}) : super(key: key);

  @override
  State<TaskQueueScreen> createState() => _TaskQueueScreenState();
}

class _TaskQueueScreenState extends State<TaskQueueScreen> {
  late int selectedTask = -1;
  late bool isSelected = false;

  /// for move to today list ///
  late String selectedTaskId = '';
  late String selectedTaskTitle = '';
  late String selectedTaskType = '';
  late String selectedGoalId = '';
  late String selectedTaskPriority = '';
  late String selectedTaskDescription = '';
  late String selectedTaskGoal = '';
  late String selectedTaskCreatedAt = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (_, _taskState, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: AppBar(
            centerTitle: false,
            shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
            title: _taskState.allTaskList.isEmpty
                ? Text(
              AppLocalizations.of(context)!.taskqueue,
              style: tTextStyle500.copyWith(fontSize: 20, color: black),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.taskqueue,
                  style:
                  tTextStyle500.copyWith(fontSize: 20, color: black),
                ),
                Text(
                  AppLocalizations.of(context)!.longpresstxt,
                  maxLines: 2,
                  style: tTextStyleRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
            actions: [
              _taskState.allTaskList.isNotEmpty ||
                  _taskState.selectedQueueType != '' ||
                  _taskState.selectedQueueTimeFrame != ''
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                    onTap: () {
                      CustomDialog.bottomSheet(
                          context, const TaskQueueFilterBottomSheet());
                    },
                    child: SvgPicture.asset(filterIcon)),
              )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        body: _allTaskListWidget(context),
      );
    });
  }

  Widget _allTaskListWidget(BuildContext context) {
    final taskState = Provider.of<TaskProvider>(context, listen: false);

    if (taskState.isAllTaskLoading) {
      return const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ));
    } else {
      if (taskState.allTaskList.isEmpty) {
        if (taskState.selectedQueueType == '' ||
            taskState.selectedQueueTimeFrame == '') {
          return Center(
            child: EmptyWidget(
                icon: taskIcon,
                title: AppLocalizations.of(context)!.notasksonqueue,
                subTitle: AppLocalizations.of(context)!.gobacktxt),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: secondaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                taskState.selectedQueueTimeFrame,
                                style: tTextStyleBold.copyWith(
                                    color: white, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    taskState.getQueueFilterTimeType('', '');
                                    await taskState.getAllTaskList();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      eightHorizontalSpace,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: secondaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                taskState.selectedQueueType,
                                style: tTextStyleBold.copyWith(
                                    color: white, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    taskState.getQueueFilterTimeType('', '');
                                    await taskState.getAllTaskList();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: EmptyWidget(
                    icon: taskIcon,
                    title: AppLocalizations.of(context)!.nomatchingtasks,
                    subTitle: AppLocalizations.of(context)!.gobacktxt),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
            ],
          );
        }
      } else {
        if (taskState.selectedQueueTimeFrame == '' ||
            taskState.selectedQueueType == '') {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        var item = taskState.allTaskList[index];

                        return TaskTile(
                          onLongPress: () {
                            setState(() {
                              selectedTask = index;
                              isSelected = true;
                              selectedTaskId = item.id;
                              selectedTaskTitle = item.title;
                              selectedTaskType = item.type;
                              selectedGoalId = item.goalId!;
                              selectedTaskPriority = item.priority;
                              selectedTaskDescription = item.description;
                              selectedTaskGoal = item.goal;
                              selectedTaskCreatedAt = item.createdAt.toString();
                            });
                          },
                          title: item.title,
                          isTimeTracking: false,
                          time: item.timeframe,
                          cardColor: selectedTask == index
                              ? secondaryColor
                              : const Color(0xFFF0F1F8),
                          titleColor: selectedTask == index ? white : black,
                          timeDateColor: selectedTask == index
                              ? const Color(0xFFBFC2E0)
                              : iconColor,
                          isSelected: selectedTask == index ? true : false,
                          createdAt: item.createdAt.toString(),
                          task: item,
                        );
                      },
                      separatorBuilder: (_, index) => eightVerticalSpace,
                      itemCount: taskState.allTaskList.length),
                ),
              ),
              isSelected ? _bottomSheet(context) : const SizedBox.shrink()
            ],
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: secondaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                taskState.selectedQueueTimeFrame,
                                style: tTextStyleBold.copyWith(
                                    color: white, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    taskState.getQueueFilterTimeType('', '');
                                    await taskState.getAllTaskList();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      eightHorizontalSpace,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: secondaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                taskState.selectedQueueType,
                                style: tTextStyleBold.copyWith(
                                    color: white, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    taskState.getQueueFilterTimeType('', '');
                                    await taskState.getAllTaskList();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        var item = taskState.allTaskList[index];

                        return TaskTile(
                          onLongPress: () {
                            setState(() {
                              selectedTask = index;
                              isSelected = true;
                              selectedTaskId = item.id;
                              selectedTaskTitle = item.title;
                              selectedTaskType = item.type;
                              selectedGoalId = item.goalId!;
                              selectedTaskPriority = item.priority;
                              selectedTaskDescription = item.description;
                              selectedTaskGoal = item.goal;
                              selectedTaskCreatedAt = item.createdAt.toString();
                            });
                          },
                          title: item.title,
                          isTimeTracking: false,
                          time: item.timeframe,
                          cardColor: selectedTask == index
                              ? secondaryColor
                              : const Color(0xFFF0F1F8),
                          titleColor: selectedTask == index ? white : black,
                          timeDateColor: selectedTask == index
                              ? const Color(0xFFBFC2E0)
                              : iconColor,
                          isSelected: selectedTask == index ? true : false,
                          createdAt: item.createdAt.toString(),
                          task: item,
                        );
                      },
                      separatorBuilder: (_, index) => eightVerticalSpace,
                      itemCount: taskState.allTaskList.length),
                ),
              ),
              isSelected ? _bottomSheet(context) : const SizedBox.shrink()
            ],
          );
        }
      }
    }
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
                      selectedGoalId,
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
                    AppLocalizations.of(context)!.movetotodaystasks,
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

}
