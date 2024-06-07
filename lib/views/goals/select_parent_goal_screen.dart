import 'package:TaskRM/views/goals/select_sub_goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../routes/routes.dart';
import '../../utils/custom_dialog.dart';

class SelectParentGoalScreen extends StatefulWidget {
  final String type;

  const SelectParentGoalScreen({Key? key, required this.type})
      : super(key: key);

  @override
  State<SelectParentGoalScreen> createState() => _SelectParentGoalScreenState();
}

class _SelectParentGoalScreenState extends State<SelectParentGoalScreen> {
  // late String selectedParentGoal = widget.parentGoal;
  late String selectedGoal = '';
  late String selectedGoalId = '';

  @override
  void initState() {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    goalState.parentGoalListForCreatingGoal(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
        title: Text(
          AppLocalizations.of(context)!.selectparentgoal,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
      ),
      body: Consumer<GoalProvider>(builder: (_, goalState, child) {
        if (goalState.isSelectorParentGoalLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (goalState.selectorParentGoalList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _optionTile(
                  onTap: () {
                    setState(() {
                      selectedGoal = 'None';
                    });
                    goalState.getSelectedParentGoal(
                        'None', '0', false, context);
                    goalState.getFilterType('');
                   // goalState.getParentGoalList();
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
                    var item = goalState.selectorParentGoalList[index];
                    return _optionTile(
                        onTap: () {
                          setState(() {
                            selectedGoal = item.title;
                            selectedGoalId = item.id;
                          });
                          goalState.getSelectedParentGoal(
                              item.title, item.id, false, context);
                          goalState.getFilterType('');
                          Navigator.pushNamed(context, Routes.selectSubGoalScreen,   arguments: {
                            'goalTitle': selectedGoal,
                            'parentGoalId': selectedGoalId,
                            'type': widget.type,
                          },);
                          // goalState.getSubGoalList(selectedGoalId);
                          // CustomDialog.bottomSheet(
                          //     context,
                          //     SelectSubGoalBottomSheet(
                          //       goalTitle: item.title,
                          //     ));
                          // Navigator.pop(context);
                        },
                        tileBorderColor: selectedGoal == item.title
                            ? secondaryColor
                            : borderColor,
                        circleColor:
                            selectedGoal == item.title ? secondaryColor : trans,
                        title: item.title);
                  },
                  separatorBuilder: (_, index) => eightVerticalSpace,
                  itemCount: goalState.selectorParentGoalList.length),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
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
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
