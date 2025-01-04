import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/add_task_bottom_sheet.dart';
import 'package:TaskRM/views/tasks/newTask/today_filter_bottomsheet.dart';
import 'package:TaskRM/widgets/components/custom_loader.dart';
import 'package:TaskRM/widgets/components/task_tile.dart';
import 'package:TaskRM/widgets/empty_widget.dart';

class TodayTaskScreen extends StatefulWidget {
  const TodayTaskScreen({Key? key}) : super(key: key);

  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreenState();
}

class _TodayTaskScreenState extends State<TodayTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (_, taskState, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
          title: Text(
            'Today’s tasks',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          actions: [
            taskState.todayTaskList.isNotEmpty ||
                    taskState.selectedFilterType != ''
                ? InkWell(
                    onTap: () {
                      CustomDialog.bottomSheet(
                          context, const TodayFilterBottomSheet());
                    },
                    child: SvgPicture.asset(filterIcon))
                : const SizedBox.shrink(),
            taskState.todayTaskList.isNotEmpty
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
            sixteenHorizontalSpace,
          ],
        ),

        /// streambuilder ///
        // body: StreamBuilder<List<TaskModel>>(
        //  // stream:  TaskModel.watchMessages('e4b7ee97-da40-482d-a649-ad637899a6fd'),
        //   stream: taskState.taskStream,
        //   builder: (context, snapshot) {
        //
        //     if(taskState.isTaskLoading){
        //       return const CustomLoader();
        //     }else{
        //       if (snapshot.hasData) {
        //         final taskList = snapshot.data!;
        //         return taskList.isEmpty
        //             ? const Center(
        //           child: Text('Start your conversation now :)'),
        //         )
        //             : ListView.builder(
        //           itemCount: taskList.length,
        //           itemBuilder: (context, index) {
        //             final task = taskList[index];
        //
        //             /// I know it's not good to include code that is not related
        //             /// to rendering the widget inside build method, but for
        //             /// creating an app quick and dirty, it's fine 😂
        //             //_loadProfileCache(message.profileId);
        //
        //             return ListTile(
        //               title: Text(task.title!),
        //               subtitle: Text(task.description!),
        //             );
        //           },
        //         );
        //       } else {
        //         return _emptyListWidget(context);
        //       }
        //     }
        //
        //   },
        // ),
        /// listview builder ///
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _taskList(context),
        ),
      );
    });
  }

  Widget _emptyListWidget(BuildContext context) {
    return Center(
      child: Column(
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
      ),
    );
  }

  Widget _taskList(BuildContext context) {
    final taskState = Provider.of<TaskProvider>(context, listen: false);

    if (taskState.isTaskLoading) {
      return const CustomLoader();
    } else {
      if (taskState.todayTaskList.isEmpty) {
        if (taskState.selectedFilterType == '') {
          return Center(child: _emptyListWidget(context));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        taskState.selectedFilterType,
                        style:
                            tTextStyleBold.copyWith(color: white, fontSize: 16),
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
              Center(child: _emptyListWidget(context)),
              const SizedBox(
                height: 10,
                width: 10,
              ),
            ],
          );
        }
      } else {
        if (taskState.selectedFilterType == '') {
          return ListView.separated(
              itemBuilder: (_, index) {
                var item = taskState.todayTaskList[index];
                return TaskTile(
                  onLongPress: () {},
                  title: item.title!,
                  isTimeTracking: false,
                  time: item.timeframe!,
                  cardColor: const Color(0xFFF0F1F8),
                  titleColor: black,
                  timeDateColor: iconColor,
                  isSelected: false,
                  createdAt: item.createdAt.toString(),
                  task: item,
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
                        style:
                            tTextStyleBold.copyWith(color: white, fontSize: 16),
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
                        title: item.title!,
                        isTimeTracking: false,
                        time: item.timeframe!,
                        cardColor: const Color(0xFFF0F1F8),
                        titleColor: black,
                        timeDateColor: iconColor,
                        isSelected: false,
                        createdAt: item.createdAt.toString(),
                        task: item,
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
}
