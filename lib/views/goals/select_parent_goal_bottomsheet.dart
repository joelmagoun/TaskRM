import 'package:TaskRM/views/goals/select_sub_goal_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/custom_dialog.dart';

class SelectParentGoalBottomSheet extends StatefulWidget {
  final String type;

  const SelectParentGoalBottomSheet({Key? key, required this.type})
      : super(key: key);

  @override
  State<SelectParentGoalBottomSheet> createState() =>
      _SelectParentGoalBottomSheetState();
}

class _SelectParentGoalBottomSheetState
    extends State<SelectParentGoalBottomSheet> {
  // late String selectedParentGoal = widget.parentGoal;
  late String selectedGoal = '';
  late String selectedGoalId = '';

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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.clear,
                            color: trans,
                          )),
                      Text(
                        AppLocalizations.of(context)!.selectparentgoal,
                        style:
                            tTextStyle500.copyWith(fontSize: 20, color: black),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: iconColor,
                          )),
                    ],
                  ),
                ),
                const Divider(),

                /// new code ///
                goalState.allParentGoalList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _optionTile(
                            onTap: () {
                              setState(() {
                                selectedGoal = 'None';
                              });
                              goalState.getSelectedParentGoal(
                                  'None', '0', false, context);
                              goalState.getFilterType('');
                              goalState.getParentGoalList();
                              Navigator.pop(context);
                            },
                            tileBorderColor: selectedGoal == 'None'
                                ? secondaryColor
                                : borderColor,
                            circleColor:
                                selectedGoal == 'None' ? secondaryColor : trans,
                            title: 'None'),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.separated(
                              itemBuilder: (_, index) {
                                var item = goalState.allParentGoalList[index];
                                return _optionTile(
                                    onTap: () {
                                      setState(() {
                                        selectedGoal = item.title;
                                        selectedGoalId = item.id;
                                      });
                                      goalState.getSelectedParentGoal(
                                          item.title, item.id, false, context);
                                      goalState.getFilterType('');
                                      goalState.getSubGoalList(selectedGoalId);
                                      CustomDialog.bottomSheet(
                                          context,
                                          SelectSubGoalBottomSheet(
                                            goalTitle: item.title,
                                          ));
                                     // Navigator.pop(context);
                                    },
                                    tileBorderColor: selectedGoal == item.title
                                        ? secondaryColor
                                        : borderColor,
                                    circleColor: selectedGoal == item.title
                                        ? secondaryColor
                                        : trans,
                                    title: item.title);
                              },
                              separatorBuilder: (_, index) =>
                                  eightVerticalSpace,
                              itemCount: goalState.allParentGoalList.length),
                        ),
                      ),
              ],
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
