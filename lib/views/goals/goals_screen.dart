import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/goals_provider.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/goals/add_new_goal_%20bottomsheet.dart';
import 'package:task_rm/views/tasks/taskQueue/filter_bottom_sheet.dart';
import 'package:task_rm/widgets/components/task_tile.dart';
import 'package:task_rm/widgets/empty_widget.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<GoalProvider>(builder: (_, _goalState, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
          title: Text(
            'Goals',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          actions: [
            _goalState.allGoalList.isNotEmpty
                ? InkWell(
                    onTap: () {
                      CustomDialog.bottomSheet(
                          context, const FilterBottomSheet());
                    },
                    child: SvgPicture.asset(filterIcon))
                : const SizedBox.shrink(),
            _goalState.allGoalList.isNotEmpty
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
          ],
        ),
        body: _goalState.allGoalList.isEmpty
            ? _emptyListWidget(context)
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: _goalState.isGoalLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: primaryColor,
                      ))
                    : ListView.separated(
                        itemBuilder: (_, index) {
                          var item = _goalState.allGoalList[index];
                          return TaskTile(
                            onLongPress: () {},
                            title: item.title,
                            isTimeTracking: false,
                            time: '00',
                            cardColor: const Color(0xFFF0F1F8),
                            titleColor: black,
                            timeDateColor: textGreyColor,
                            isSelected: false,
                            createdAt: item.createdAt.toString(),
                          );
                        },
                        separatorBuilder: (_, index) => eightVerticalSpace,
                        itemCount: _goalState.allGoalList.length),
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
            icon: goalIcon,
            title: 'What do you aspire to achieve?',
            subTitle:
                'Add your personal and work goals to begin working on them.'),
        sixteenVerticalSpace,
        IconButton(
          onPressed: () {
            CustomDialog.bottomSheet(context, const AddNewGoalBottomSheet());
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
