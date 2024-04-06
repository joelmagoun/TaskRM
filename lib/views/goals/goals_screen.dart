import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/models/goal.dart';
import 'package:task_rm/models/task.dart';
import 'package:task_rm/providers/goals_provider.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/goals/add_new_goal_%20bottomsheet.dart';
import 'package:task_rm/views/goals/goal_filter_bottomsheet.dart';
import 'package:task_rm/views/goals/widgets/goal_tile.dart';
import 'package:task_rm/widgets/components/task_tile.dart';
import 'package:task_rm/widgets/empty_widget.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalProvider>(builder: (_, goalState, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
          title: Text(
            'Goals',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          actions: [
            if (goalState.allGoalList.isNotEmpty ||
                goalState.selectedFilterType != '')
              InkWell(
                  onTap: () {
                    CustomDialog.bottomSheet(
                        context, const GoalFilterBottomSheet());
                  },
                  child: SvgPicture.asset(filterIcon))
            else
              const SizedBox.shrink(),
            goalState.allGoalList.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      CustomDialog.bottomSheet(
                          context, const AddNewGoalBottomSheet());
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _goalList(context),
        ),
      );
    });
  }

  Widget _goalList(BuildContext context) {
    final goalState = Provider.of<GoalProvider>(context, listen: false);

    if (goalState.isGoalLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: primaryColor,
      ));
    } else {
      if (goalState.allGoalList.isEmpty) {
        if (goalState.selectedFilterType == '') {
          return const Center(
            child: EmptyWidget(
                icon: goalIcon,
                title: 'What do you aspire to achieve?',
                subTitle:
                    'Add your personal and work goals to begin working on them.'),
          );
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
                        goalState.selectedFilterType,
                        style:
                            tTextStyleBold.copyWith(color: white, fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () async {
                            goalState.getFilterType('');
                            await goalState.getGoalList();
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: white,
                          ))
                    ],
                  ),
                ),
              ),
              const Center(
                child: EmptyWidget(
                    icon: goalIcon,
                    title: 'Sorry!',
                    subTitle: 'No matching goals'),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              )
            ],
          );
        }
      } else {
        if (goalState.selectedFilterType == '') {
          return ListView.separated(
              itemBuilder: (_, index) {
                var item = goalState.allGoalList[index];
                return GoalTile(
                  goalId: item.id,
                  onLongPress: () {},
                  title: item.title,
                  isTimeTracking: false,
                  time: '00',
                  cardColor: const Color(0xFFF0F1F8),
                  titleColor: black,
                  timeDateColor: iconColor,
                  isSelected: false,
                  createdAt: item.createdAt.toString(),
                  goal: Goal(
                      id: item.id,
                      title: item.title,
                      type: item.type,
                      description: item.description,
                      isCompleted: item.isCompleted,
                      userId: item.userId),
                );
              },
              separatorBuilder: (_, index) => eightVerticalSpace,
              itemCount: goalState.allGoalList.length);
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
                        goalState.selectedFilterType,
                        style:
                            tTextStyleBold.copyWith(color: white, fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () async {
                            goalState.getFilterType('');
                            await goalState.getGoalList();
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
                      var item = goalState.allGoalList[index];
                      return TaskTile(
                        onLongPress: () {},
                        title: item.title,
                        isTimeTracking: false,
                        time: '00',
                        cardColor: const Color(0xFFF0F1F8),
                        titleColor: black,
                        timeDateColor: iconColor,
                        isSelected: false,
                        createdAt: item.createdAt.toString(),
                        task: Task(
                            id: '',
                            title: '',
                            type: '',
                            priority: '',
                            timeframe: '',
                            description: '',
                            createdAt: DateTime.now(),
                            expectedCompletion: DateTime.now(),
                            isMarkedForToday: false,
                            jiraID: '',
                            userID: '',
                            goal: goal),
                      );
                    },
                    separatorBuilder: (_, index) => eightVerticalSpace,
                    itemCount: goalState.allGoalList.length),
              )
            ],
          );
        }
      }
    }
  }
}
