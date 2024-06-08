import 'package:TaskRM/providers/goals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/widgets/empty_widget.dart';
import '../../../models/goal.dart';
import '../../../routes/routes.dart';
import '../../../utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/constant/constant.dart';
import '../../../widgets/components/task_tile.dart';
import '../widgets/goal_tile.dart';
import 'editGoal/edit_goal_bottomsheet.dart';

class SubGoalDetailsScreen extends StatefulWidget {
  final Goal goal;

  const SubGoalDetailsScreen({Key? key, required this.goal}) : super(key: key);

  @override
  State<SubGoalDetailsScreen> createState() => _SubGoalDetailsScreenState();
}

class _SubGoalDetailsScreenState extends State<SubGoalDetailsScreen> {
  late bool isData = false;

  @override
  void initState() {
    print('sub goal id ${widget.goal.id}');
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    goalState.getSubGoalList(widget.goal.id);
    goalState.getAllGoalTaskList(widget.goal.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalProvider>(builder: (_, goalState, child) {
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
                  style: tTextStyle500.copyWith(
                      fontSize: 20, color: textPrimaryColor),
                ),
              ],
            ),
            actions: [
              PopupMenuButton(
                icon: SvgPicture.asset(menuIcon),
                color: white,
                onSelected: (value) {
                  // your logic
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        CustomDialog.bottomSheet(
                            context, EditGoalBottomSheet(goal: widget.goal));
                      },
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit_outlined),
                          eightHorizontalSpace,
                          Text(AppLocalizations.of(context)!.edit),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: '/hello',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_outline,
                            color: red,
                          ),
                          eightHorizontalSpace,
                          Text(
                            AppLocalizations.of(context)!.delete,
                            style: tTextStyle600.copyWith(color: red),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
              sixteenHorizontalSpace,
            ],
            bottom: TabBar(
                indicatorColor: primaryColor,
                labelStyle: tTextStyle500.copyWith(
                    color: textPrimaryColor, fontSize: 16),
                unselectedLabelStyle:
                tTextStyle500.copyWith(color: iconColor, fontSize: 16),
                tabs: const [
                  Tab(
                    text: 'Goals',
                  ),
                  Tab(
                    text: 'Tasks',
                  ),
                  Tab(
                    text: 'Details',
                  )
                ]),
          ),
          body: goalState.isSubGoalLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TabBarView(children: [
                    _goalsBody(),
                    _tasksBody(),
                    _detailsBody()
                  ]),
                ),
              ),
              _bottomSheet(),
            ],
          ),
        ),
      );
    });
  }

  Widget _goalsBody() {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    if (goalState.allSubGoalList.isEmpty) {
      return const EmptyWidget(
          icon: goalIcon,
          title: 'No sub-goals',
          subTitle:
          'You can add sub-goals by editing other goals or adding new ones');
    } else {
      return ListView.separated(
          itemBuilder: (_, index) {
            var item = goalState.allSubGoalList[index];
            return GoalTile(
              goalId: item.id,
              onLongPress: () {},
              onTap: () {
                goalState.getSubGoalList(widget.goal.id).then((value) {
                  if(goalState.allSubGoalList.isEmpty){
                    return null;
                  }else{
                    goalState.getAllGoalTaskList(widget.goal.id);
                    Navigator.pushNamed(context, Routes.goalDetails,
                        arguments: Goal(
                            id: item.id,
                            title: item.title,
                            type: item.type,
                            description: item.description,
                            parentGoal: item.parentGoal,
                            isCompleted: item.isCompleted,
                            userId: item.userId));
                  }
                });



              },
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
                  parentGoal: item.parentGoal,
                  isCompleted: item.isCompleted,
                  userId: item.userId),
            );
          },
          separatorBuilder: (_, index) => eightVerticalSpace,
          itemCount: goalState.allSubGoalList.length);
    }
  }

  Widget _tasksBody() {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    if (goalState.allGoalTaskList.isEmpty) {
      return const Center(
        child: EmptyWidget(
            icon: taskIcon,
            title: 'Sorry!',
            subTitle: 'No matching task with this goal'),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              itemBuilder: (_, index) {
                var item = goalState.allGoalTaskList[index];
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
                  task: item,
                );
              },
              separatorBuilder: (_, index) => eightVerticalSpace,
              itemCount: goalState.allGoalTaskList.length),
        ),
      );
    }
  }

  Widget _detailsBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _infoTile(typeIcon, AppLocalizations.of(context)!.type,
              AppConstant.convertType(context, widget.goal.type), false),
          primaryVerticalSpace,
          //_infoTile(timeFrameIcon, AppLocalizations.of(context)!.timeframe,
          //    " widget.goal.timeFrame", false),
          //primaryVerticalSpace,
          _infoTile(descriptionIcon, AppLocalizations.of(context)!.description,
              widget.goal.description, false),
          primaryVerticalSpace,
          _infoTile(goalIcon, AppLocalizations.of(context)!.parentgoal,
               widget.goal.parentGoal, true),
          primaryVerticalSpace,
          _infoTile(
              taskIcon, AppLocalizations.of(context)!.tasks, 'None', true),
          primaryVerticalSpace,
          _infoTile(scheduleIcon, AppLocalizations.of(context)!.timespent,
              '1 hr 15 min', false),
          primaryVerticalSpace,
          _infoTile(reloadIcon, AppLocalizations.of(context)!.lastactivity,
              '11 Mar, 2023', false),
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
            _bottomButton(
                addTimeIcon, AppLocalizations.of(context)!.addtime, false),
            _bottomButton(
                checkIcon, AppLocalizations.of(context)!.completegoal, true),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(String icon, String title, bool isComplete) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        eightVerticalSpace,
        Text(
          title,
          style: tTextStyle500.copyWith(
              fontSize: 14, color: isComplete ? primaryColor : secondaryColor),
        )
      ],
    );
  }
}
