import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/task_provider.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/add_task_bottom_sheet.dart';
import 'package:task_rm/views/tasks/newTask/today_filter_bottomsheet.dart';
import 'package:task_rm/widgets/components/task_tile.dart';
import 'package:task_rm/widgets/empty_widget.dart';

class TodayTaskScreen extends StatefulWidget {
  const TodayTaskScreen({Key? key}) : super(key: key);

  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreenState();
}

class _TodayTaskScreenState extends State<TodayTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (_, _taskState, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
          title: Text(
            'Today’s tasks',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          actions: [
            _taskState.todayTaskList.isNotEmpty ||
                    _taskState.selectedFilterType != ''
                ? InkWell(
                    onTap: () {
                      CustomDialog.bottomSheet(
                          context, const TodayFilterBottomSheet());
                    },
                    child: SvgPicture.asset(filterIcon))
                : const SizedBox.shrink(),
            _taskState.todayTaskList.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      CustomDialog.bottomSheet(
                          context, const AddTaskBottomSheet());
                    },
                    icon: const Icon(
                      Icons.add_circle_rounded,
                    ),
                    color: primaryColor,
                    iconSize: 42,
                  )
                : const SizedBox.shrink(),
          ],
        ),
        body: _taskState.todayTaskList.isEmpty
            ? _emptyListWidget(context)
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: _taskList(context),
              ),
      );
    });
  }

  Widget _emptyListWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EmptyWidget(
            icon: taskIcon,
            title: 'No tasks for today',
            subTitle:
                'Add tasks by creating new ones or selecting from the queue.'),
        sixteenVerticalSpace,
        IconButton(
          onPressed: () {
            CustomDialog.bottomSheet(context, const AddTaskBottomSheet());
          },
          icon: const Icon(
            Icons.add_circle_rounded,
          ),
          color: primaryColor,
          iconSize: 64,
        )
      ],
    );
  }

  Widget _taskList(BuildContext context) {

    final taskState = Provider.of<TaskProvider>(context, listen: false);

    if (taskState.isTaskLoading) {
      return const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ));
    } else {
      if (taskState.selectedFilterType == '') {
        return ListView.separated(
            itemBuilder: (_, index) {
              var item = taskState.todayTaskList[index];
              return TaskTile(
                onLongPress: () {},
                title: item.title,
                isTimeTracking: false,
                time: item.timeframe,
                cardColor: const Color(0xFFF0F1F8),
                titleColor: black,
                timeDateColor: iconColor,
                isSelected: false,
                createdAt: item.createdAt.toString(),
              );
            },
            separatorBuilder: (_, index) => eightVerticalSpace,
            itemCount: taskState.todayTaskList.length);
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eightVerticalSpace,
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
                      taskState.selectedFilterType,
                      style: tTextStyleBold.copyWith(color: white, fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () async {
                          taskState.getFilterType('');
                          await taskState.getTodayTaskList();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: white,
                        ))
                  ],
                ),
              ),
            ),
            sixteenVerticalSpace,
            Expanded(
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    var item = taskState.todayTaskList[index];
                    return TaskTile(
                      onLongPress: () {},
                      title: item.title,
                      isTimeTracking: false,
                      time: item.timeframe,
                      cardColor: const Color(0xFFF0F1F8),
                      titleColor: black,
                      timeDateColor: iconColor,
                      isSelected: false,
                      createdAt: item.createdAt.toString(),
                    );
                  },
                  separatorBuilder: (_, index) => eightVerticalSpace,
                  itemCount: taskState.todayTaskList.length),
            )
          ],
        );
      }
    }
  }

}
