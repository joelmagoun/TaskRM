import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/auth_provider.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/widgets/task_tile.dart';
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
    return Consumer<AuthProvider>(builder: (_, _authState, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
          title: _taskQueue.isEmpty
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
                    )
                  ],
                ),
          actions: [
            _taskQueue.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SvgPicture.asset(filterIcon),
                  )
          ],
        ),
        body: Center(
            child: _taskQueue.isEmpty
                ? _emptyListWidget(context)
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.separated(
                            itemBuilder: (_, index) {
                              return TaskTile(
                                onLongPress: () {
                                  setState(() {
                                    selectedTask = index;
                                    isSelected = true;
                                  });
                                },
                                title: 'Check and respond to emails by 9:30 AM',
                                isTimeTracking: false,
                                time: '1 hr',
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
                                sixteenVerticalSpace,
                            itemCount: 10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade600,
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                  offset: const Offset(0, 15))
                            ]),
                      )
                    ],
                  )),
      );
    });
  }

  Widget _emptyListWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          taskIcon,
          height: 120,
          width: 120,
          color: assColor,
        ),
        sixteenVerticalSpace,
        Text(
          'No tasks on your queue',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        Text(
          'Go back, then add new tasks',
          textAlign: TextAlign.center,
          style: tTextStyleRegular.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
