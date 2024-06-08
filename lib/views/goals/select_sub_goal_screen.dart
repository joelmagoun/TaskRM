import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/goal.dart';

class SelectSubGoalScreen extends StatefulWidget {
  final String goalTitle;
  final String parentGoalId;
  final String type;

  const SelectSubGoalScreen(
      {Key? key,
      required this.goalTitle,
      required this.parentGoalId,
      required this.type})
      : super(key: key);

  @override
  State<SelectSubGoalScreen> createState() => _SelectSubGoalScreenState();
}

class _SelectSubGoalScreenState extends State<SelectSubGoalScreen> {
  // late String selectedParentGoal = widget.parentGoal;
  late String selectedGoal = '';

  @override
  void initState() {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    goalState.subGoalListForCreatingGoal(widget.parentGoalId, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Parent Goal',
              style: tTextStyle500.copyWith(fontSize: 14, color: iconColor),
            ),
            Text(
              widget.goalTitle,
              style: tTextStyle500.copyWith(fontSize: 20, color: black),
            ),
          ],
        ),
      ),
      body: Consumer<GoalProvider>(builder: (_, goalState, child) {
        if (goalState.isSelectorSubGoalLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (goalState.selectorSubGoalList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: _optionTile(
                  onTap: () {
                    setState(() {
                      selectedGoal = 'None';
                    });
                    goalState.getSelectedParentGoal(
                        'None', '0', false, context);
                    goalState.getFilterType('');
                    //goalState.getParentGoalList();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  tileBorderColor:
                      selectedGoal == 'None' ? secondaryColor : borderColor,
                  circleColor: selectedGoal == 'None' ? secondaryColor : trans,
                  title: 'None'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    var item = goalState.selectorSubGoalList[index];
                    return _optionTile(
                        onTap: () {
                          setState(() {
                            selectedGoal = item.title;
                          });
                          goalState.getSelectedParentGoal(
                              item.title, item.id, false, context);
                          goalState.getFilterType('');
                          // goalState.getParentGoalList();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        tileBorderColor: selectedGoal == item.title
                            ? secondaryColor
                            : borderColor,
                        circleColor:
                            selectedGoal == item.title ? secondaryColor : trans,
                        title: item.title);
                  },
                  separatorBuilder: (_, index) => eightVerticalSpace,
                  itemCount: goalState.selectorSubGoalList.length),
            );
          }
        }
      }),
    );
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
                width: MediaQuery.of(context).size.width / 1.6,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: tTextStyleRegular.copyWith(
                      fontSize: 16, color: black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
