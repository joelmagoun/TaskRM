import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/auth_provider.dart';
import 'package:task_rm/providers/task_provider.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/add_task_bottom_sheet.dart';
import 'package:task_rm/views/tasks/widgets/task_tile.dart';
import 'package:task_rm/widgets/empty_widget.dart';
import '../../utils/assets_path.dart';

class TodayTaskScreen extends StatelessWidget {
  const TodayTaskScreen({Key? key}) : super(key: key);

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
        ),
        body: _emptyListWidget(context),
        // body: _taskState.allTaskList.isEmpty
        //     ? _emptyListWidget(context)
        //     : ListView.separated(
        //     itemBuilder: (_, index) {
        //       var item = _taskState.allTaskList[index];
        //       return TaskTile(onLongPress: (){},
        //           title: item.title,
        //           isTimeTracking: false,
        //           time: item.timeframe,
        //           date: '12/01/2024',
        //           cardColor: cardColor,
        //           titleColor: titleColor,
        //           timeDateColor: timeDateColor,
        //           isSelected: isSelected)
        //     },
        //     separatorBuilder: (_, index) => eightVerticalSpace,
        //     itemCount: _taskState.allTaskList.length),
      );
    });
  }

  Widget _emptyListWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EmptyWidget(
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
}
