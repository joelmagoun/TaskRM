import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectParentGoalBottomSheet extends StatefulWidget {
  final String parentGoal;

  const SelectParentGoalBottomSheet({Key? key, required this.parentGoal})
      : super(key: key);

  @override
  State<SelectParentGoalBottomSheet> createState() =>
      _SelectParentGoalBottomSheetState();
}

class _SelectParentGoalBottomSheetState
    extends State<SelectParentGoalBottomSheet> {
  late String selectedParentGoal = widget.parentGoal;

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
          child: Consumer<GoalProvider>(builder: (_, _goalState, child) {
            return SingleChildScrollView(
              child: Column(
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
                          style: tTextStyle500.copyWith(
                              fontSize: 20, color: black),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedParentGoal = 'None';
                            });
                            _goalState.getSelectedParentGoal(
                                'None', false, context);
                          },
                          tileBorderColor: selectedParentGoal == 'None'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedParentGoal == 'None'
                              ? secondaryColor
                              : trans,
                          title: 'None',
                        ),
                        sixteenVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedParentGoal =
                                  'Work towards obtaining certifications that are valuable...';
                            });

                            _goalState.getSelectedParentGoal(
                                'Work towards obtaining certifications that are valuable...',
                                false,
                                context);
                          },
                          tileBorderColor: selectedParentGoal ==
                                  'Work towards obtaining certifications that are valuable...'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedParentGoal ==
                                  'Work towards obtaining certifications that are valuable...'
                              ? secondaryColor
                              : trans,
                          title:
                              'Work towards obtaining certifications that are valuable...',
                        ),
                        eightVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedParentGoal =
                                  'Read 4 of self-improvement books within the next six mon...';
                            });
                            _goalState.getSelectedParentGoal(
                                'Read 4 of self-improvement books within the next six mon...',
                                false,
                                context);
                          },
                          tileBorderColor: selectedParentGoal ==
                                  'Read 4 of self-improvement books within the next six mon...'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedParentGoal ==
                                  'Read 4 of self-improvement books within the next six mon...'
                              ? secondaryColor
                              : trans,
                          title:
                              'Read 4 of self-improvement books within the next six mon...',
                        ),
                        sixteenVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedParentGoal =
                                  'Explore and participate in adventurous activities.';
                            });
                            _goalState.getSelectedParentGoal(
                                'Explore and participate in adventurous activities.',
                                false,
                                context);
                          },
                          tileBorderColor: selectedParentGoal ==
                                  'Explore and participate in adventurous activities.'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedParentGoal ==
                                  'Explore and participate in adventurous activities.'
                              ? secondaryColor
                              : trans,
                          title:
                              'Explore and participate in adventurous activities.',
                        ),
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
