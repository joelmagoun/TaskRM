import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../models/goal.dart';
import '../../../utils/assets_path.dart';
import 'package:TaskRM/views/goals/widgets/goal_tile.dart';
import 'package:TaskRM/widgets/empty_widget.dart';
import 'package:TaskRM/widgets/components/task_tile.dart';

class GoalDetailsScreen extends StatefulWidget {
  final Goal goal;

  const GoalDetailsScreen({Key? key, required this.goal}) : super(key: key);

  @override
  State<GoalDetailsScreen> createState() => _GoalDetailsScreenState();
}

class _GoalDetailsScreenState extends State<GoalDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    goalState.getSubGoals(widget.goal.id);
    goalState.getGoalTasks(widget.goal.id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goal',
                style: tTextStyle500.copyWith(fontSize: 14, color: iconColor),
              ),
              Text(
                widget.goal.title,
                style: tTextStyle500.copyWith(fontSize: 20, color: textPrimaryColor),
              ),
            ],
          ),
          actions: [
            SvgPicture.asset(menuIcon),
            sixteenHorizontalSpace,
          ],
          bottom: TabBar(
            indicatorColor: primaryColor,
            labelStyle: tTextStyle500.copyWith(color: textPrimaryColor, fontSize: 16),
            unselectedLabelStyle: tTextStyle500.copyWith(color: iconColor, fontSize: 16),
            tabs: const [
              Tab(text: 'Goals'),
              Tab(text: 'Tasks'),
              Tab(text: 'Details'),
            ],
          ),
        ),
        body: Consumer<GoalProvider>(
          builder: (context, goalState, child) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TabBarView(
                      children: [
                        _goalsTab(goalState),
                        _tasksTab(goalState),
                        _detailsTab(),
                      ],
                    ),
                  ),
                ),
                _bottomSheet(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _goalsTab(GoalProvider goalState) {
    if (goalState.isLoadingSubGoals) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (goalState.subGoals.isEmpty) {
      return const EmptyWidget(
        icon: goalIcon,
        title: 'No sub-goals',
        subTitle: 'You can add sub-goals by editing other goals or adding new ones',
      );
    }

    return ListView.separated(
      itemCount: goalState.subGoals.length,
      separatorBuilder: (_, __) => eightVerticalSpace,
      itemBuilder: (context, index) {
        final goal = goalState.subGoals[index];
        return GoalTile(
          goalId: goal.id,
          onLongPress: () {},
          title: goal.title,
          isTimeTracking: false,
          time: '0',
          cardColor: const Color(0xFFF0F1F8),
          titleColor: black,
          timeDateColor: iconColor,
          isSelected: false,
          createdAt: goal.createdAt.toString(),
          goal: goal,
        );
      },
    );
  }

  Widget _tasksTab(GoalProvider goalState) {
    if (goalState.isLoadingGoalTasks) {
      return const Center(child: CircularProgressIndicator());
    }

    if (goalState.goalTasks.isEmpty) {
      return const EmptyWidget(
        icon: taskIcon,
        title: 'No tasks',
        subTitle: 'No tasks are associated with this goal',
      );
    }

    return ListView.separated(
      itemCount: goalState.goalTasks.length,
      separatorBuilder: (_, __) => eightVerticalSpace,
      itemBuilder: (context, index) {
        final task = goalState.goalTasks[index];
        return TaskTile(
          onLongPress: () {},
          title: task.title ?? '',
          isTimeTracking: false,
          time: task.timeframe ?? '0',
          cardColor: const Color(0xFFF0F1F8),
          titleColor: black,
          timeDateColor: iconColor,
          isSelected: false,
          createdAt: task.createdAt.toString(),
          task: task,
        );
      },
    );
  }

  Widget _detailsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _infoTile(typeIcon, 'Type', widget.goal.type, false),
          primaryVerticalSpace,
          _infoTile(descriptionIcon, 'Description', widget.goal.description, false),
          primaryVerticalSpace,
          _infoTile(goalIcon, 'Parent Goal', widget.goal.parentGoal ?? 'None', true),
          primaryVerticalSpace,
          _infoTile(taskIcon, 'Tasks', 'None', true),
          primaryVerticalSpace,
          _infoTile(scheduleIcon, 'Time spent', '1 hr 15 min', false),
          primaryVerticalSpace,
          _infoTile(reloadIcon, 'Last activity', '11 Mar, 2023', false),
        ],
      ),
    );
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
                  fontSize: 14,
                  color: isGoal ? primaryColor : const Color(0xFFAAAAAA)),
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
            _bottomButton(addTimeIcon, 'Add Time', false),
            _bottomButton(checkIcon, 'Complete Goal', true),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(String icon, String title, bool isComplete) {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    
    return InkWell(
      onTap: () {
        if (isComplete) {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Complete Goal'),
              content: Text('Are you sure you want to mark this goal as complete?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    goalState.toggleGoalComplete(
                      widget.goal.id,
                      widget.goal.isCompleted,
                      context,
                    );
                    Navigator.pop(context); // Return to previous screen
                  },
                  child: Text('Complete'),
                ),
              ],
            ),
          );
        }
      },
      child: Column(
        children: [
          goalState.isCompletingGoal && isComplete
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
