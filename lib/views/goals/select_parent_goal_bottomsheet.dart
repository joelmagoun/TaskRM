import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';

class SelectParentGoalBottomSheet extends StatefulWidget {
  const SelectParentGoalBottomSheet({Key? key}) : super(key: key);

  @override
  State<SelectParentGoalBottomSheet> createState() =>
      _SelectParentGoalBottomSheetState();
}

class _SelectParentGoalBottomSheetState
    extends State<SelectParentGoalBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GoalProvider>(context, listen: false).getParentGoalsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24), topLeft: Radius.circular(24)),
              color: white),
          child: Consumer<GoalProvider>(builder: (_, goalState, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              goalState.clearSelectedParentGoal();
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: iconColor,
                            )),
                        Text(
                          'Select Parent Goal',
                          style: tTextStyle500.copyWith(
                              fontSize: 20, color: black),
                        ),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.clear,
                              color: iconColor,
                            )),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _optionTile(
                          onTap: () {
                            goalState.clearSelectedParentGoal();
                            Navigator.pop(context);
                          },
                          tileBorderColor: goalState.selectedParentGoalId.isEmpty 
                            ? secondaryColor 
                            : borderColor,
                          circleColor: goalState.selectedParentGoalId.isEmpty 
                            ? secondaryColor 
                            : trans,
                          title: 'None',
                        ),
                        sixteenVerticalSpace,
                        ...goalState.parentGoalsList.map((goal) => Column(
                          children: [
                            _optionTile(
                              onTap: () {
                                goalState.setSelectedParentGoal(goal.id, goal.title);
                                Navigator.pop(context);
                              },
                              tileBorderColor: goalState.selectedParentGoalId == goal.id 
                                ? secondaryColor 
                                : borderColor,
                              circleColor: goalState.selectedParentGoalId == goal.id 
                                ? secondaryColor 
                                : trans,
                              title: goal.title,
                            ),
                            eightVerticalSpace,
                          ],
                        )).toList(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }

  Widget _optionTile({
    required VoidCallback onTap,
    required Color tileBorderColor,
    required Color circleColor,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: tileBorderColor)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: assColor,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: circleColor,
                ),
              ),
              eightHorizontalSpace,
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: tTextStyleRegular.copyWith(fontSize: 16, color: black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
