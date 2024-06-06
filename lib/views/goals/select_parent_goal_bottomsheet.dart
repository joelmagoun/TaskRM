import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/assets_path.dart';
import '../../widgets/empty_widget.dart';

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
                goalState.allGoalList.isEmpty
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
                        goalState.getGoalList();
                        Navigator.pop(context);
                      },
                      tileBorderColor:  selectedGoal == 'None'
                          ? secondaryColor
                          : borderColor,
                      circleColor: selectedGoal == 'None'
                          ? secondaryColor
                          : trans,
                      title: 'None'),
                    )
                    : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.separated(
                            itemBuilder: (_, index) {
                              var item = goalState.allGoalList[index];
                              return _optionTile(
                                  onTap: () {
                                    setState(() {
                                      selectedGoal = item.title;
                                    });
                                    goalState.getSelectedParentGoal(
                                        item.title, item.id, false, context);
                                    goalState.getFilterType('');
                                    goalState.getGoalList();
                                    Navigator.pop(context);
                                  },
                                  tileBorderColor: selectedGoal == item.title
                                      ? secondaryColor
                                      : borderColor,
                                  circleColor: selectedGoal == item.title
                                      ? secondaryColor
                                      : trans,
                                  title: item.title);
                            },
                            separatorBuilder: (_, index) => eightVerticalSpace,
                            itemCount: goalState.allGoalList.length),
                  ),
                ),

                /// old code ///
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Column(
                //     children: [
                //       _optionTile(
                //         onTap: () {
                //           setState(() {
                //             selectedParentGoal = '0';
                //           });
                //           goalState.getSelectedParentGoal(
                //               'None', false, context);
                //         },
                //         tileBorderColor: selectedParentGoal == '0'
                //             ? secondaryColor
                //             : borderColor,
                //         circleColor: selectedParentGoal == '0'
                //             ? secondaryColor
                //             : trans,
                //         title: 'None',
                //       ),
                //       sixteenVerticalSpace,
                //       _optionTile(
                //         onTap: () {
                //           setState(() {
                //             selectedParentGoal =
                //                 '1';
                //           });
                //
                //           goalState.getSelectedParentGoal(
                //               '1',
                //               false,
                //               context);
                //         },
                //         tileBorderColor: selectedParentGoal ==
                //                 '1'
                //             ? secondaryColor
                //             : borderColor,
                //         circleColor: selectedParentGoal ==
                //                 '1'
                //             ? secondaryColor
                //             : trans,
                //         title:
                //             'Work towards obtaining certifications that are valuable...',
                //       ),
                //       eightVerticalSpace,
                //       _optionTile(
                //         onTap: () {
                //           setState(() {
                //             selectedParentGoal =
                //                 '2';
                //           });
                //           goalState.getSelectedParentGoal(
                //               '2',
                //               false,
                //               context);
                //         },
                //         tileBorderColor: selectedParentGoal ==
                //                 '2'
                //             ? secondaryColor
                //             : borderColor,
                //         circleColor: selectedParentGoal ==
                //                 '2'
                //             ? secondaryColor
                //             : trans,
                //         title:
                //             'Read 4 of self-improvement books within the next six mon...',
                //       ),
                //       sixteenVerticalSpace,
                //       _optionTile(
                //         onTap: () {
                //           setState(() {
                //             selectedParentGoal =
                //                 '3';
                //           });
                //           goalState.getSelectedParentGoal(
                //               '3',
                //               false,
                //               context);
                //         },
                //         tileBorderColor: selectedParentGoal ==
                //                 '3'
                //             ? secondaryColor
                //             : borderColor,
                //         circleColor: selectedParentGoal ==
                //                 '3'
                //             ? secondaryColor
                //             : trans,
                //         title:
                //             'Explore and participate in adventurous activities.',
                //       ),
                //     ],
                //   ),
                // )
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
