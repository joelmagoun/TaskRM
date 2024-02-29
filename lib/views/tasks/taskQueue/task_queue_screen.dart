import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/auth_provider.dart';
import 'package:task_rm/providers/task_provider.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/taskQueue/filter_bottom_sheet.dart';
import 'package:task_rm/views/tasks/widgets/task_tile.dart';
import 'package:task_rm/widgets/empty_widget.dart';
import '../../../utils/assets_path.dart';

class TaskQueueScreen extends StatefulWidget {
  const TaskQueueScreen({Key? key}) : super(key: key);

  @override
  State<TaskQueueScreen> createState() => _TaskQueueScreenState();
}

class _TaskQueueScreenState extends State<TaskQueueScreen> {
  late List<String> _taskQueue = ['kafi'];
  late int selectedTask = -1;
  late bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (_, _taskState, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
          title: _taskState.allTaskList.isEmpty
              ? Text(
                  'Task queue',
                  style: tTextStyle500.copyWith(fontSize: 20, color: black),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task queue',
                      style: tTextStyle500.copyWith(fontSize: 20, color: black),
                    ),
                    Text(
                      'Long press a task to move it to today’s list',
                      maxLines: 2,
                      style: tTextStyleRegular.copyWith(fontSize: 14),
                    ),
                  ],
                ),
          actions: [
            _taskQueue.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                        onTap: () {
                          CustomDialog.bottomSheet(
                              context, const FilterBottomSheet());
                        },
                        child: SvgPicture.asset(filterIcon)),
                  )
          ],
        ),
        body: Center(
            child: _taskState.allTaskList.isEmpty
                ? const EmptyWidget(
                    title: 'No tasks on your queue',
                    subTitle: 'Go back, then add new tasks')
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _taskState.isTaskLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  itemBuilder: (_, index) {

                                    var item = _taskState.allTaskList[index];

                                    return TaskTile(
                                      onLongPress: () {
                                        setState(() {
                                          selectedTask = index;
                                          isSelected = true;
                                        });
                                      },
                                      title: item.title,
                                      isTimeTracking: false,
                                      time: item.timeframe,
                                      date: '13',
                                      cardColor: selectedTask == index
                                          ? secondaryColor
                                          : const Color(0xFFF0F1F8),
                                      titleColor:
                                          selectedTask == index ? white : black,
                                      timeDateColor: selectedTask == index
                                          ? const Color(0xFFBFC2E0)
                                          : textGreyColor,
                                      isSelected:
                                          selectedTask == index ? true : false,
                                    );
                                  },
                                  separatorBuilder: (_, index) =>
                                      eightVerticalSpace,
                                  itemCount: _taskState.allTaskList.length),
                        ),
                      ),
                      isSelected ? _bottomSheet() : const SizedBox.shrink()
                    ],
                  )),
      );
    });
  }

  Widget _bottomSheet() {
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
                onTap: () {},
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor,
                  ),
                  child: Text(
                    'Move to “Today’s tasks”',
                    style: tTextStyle600.copyWith(fontSize: 16, color: white),
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
