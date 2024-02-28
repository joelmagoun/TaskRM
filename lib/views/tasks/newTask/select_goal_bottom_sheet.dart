import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/new_task_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';

class SelectGoalBottomSheet extends StatefulWidget {
  const SelectGoalBottomSheet({Key? key}) : super(key: key);

  @override
  State<SelectGoalBottomSheet> createState() => _SelectGoalBottomSheetState();
}

class _SelectGoalBottomSheetState extends State<SelectGoalBottomSheet> {
  late String selectedGoal = 'Select';

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
          child: Consumer<NewTaskProvider>(builder: (_, _taskState, child) {
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
                          'Select Goal',
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
                              selectedGoal = 'None';
                            });
                            _taskState.getSelectedGoal('None', context);
                          },
                          tileBorderColor: selectedGoal == 'None'
                              ? secondaryColor
                              : borderColor,
                          circleColor:
                              selectedGoal == 'None' ? secondaryColor : trans,
                          title: 'None',
                        ),
                        sixteenVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedGoal =
                                  'Attend 6 of networking events within the industry in the';
                            });
                            _taskState.getSelectedGoal(
                                'Attend 6 of networking events within the industry in the',
                                context);
                          },
                          tileBorderColor: selectedGoal ==
                                  'Attend 6 of networking events within the industry in the'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedGoal ==
                                  'Attend 6 of networking events within the industry in the'
                              ? secondaryColor
                              : trans,
                          title:
                              'Attend 6 of networking events within the industry in the',
                        ),
                        sixteenVerticalSpace,
                        Text(
                          'Improving my personal life',
                          style: tTextStyle500.copyWith(
                              fontSize: 14, color: iconColor),
                        ),
                        eightVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedGoal =
                                  'Read 4 of self-improvement books within the next six';
                            });
                            _taskState.getSelectedGoal(
                                'Read 4 of self-improvement books within the next six',
                                context);
                          },
                          tileBorderColor: selectedGoal ==
                                  'Read 4 of self-improvement books within the next six'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedGoal ==
                                  'Read 4 of self-improvement books within the next six'
                              ? secondaryColor
                              : trans,
                          title:
                              'Read 4 of self-improvement books within the next six',
                        ),
                        sixteenVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedGoal =
                                  'Explore and participate in adventurous activities.';
                            });
                            _taskState.getSelectedGoal(
                                'Explore and participate in adventurous activities.',
                                context);
                          },
                          tileBorderColor: selectedGoal ==
                                  'Explore and participate in adventurous activities.'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedGoal ==
                                  'Explore and participate in adventurous activities.'
                              ? secondaryColor
                              : trans,
                          title:
                              'Explore and participate in adventurous activities.',
                        ),
                        sixteenVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedGoal =
                                  'complete and present the final project.';
                            });
                            _taskState.getSelectedGoal(
                                'complete and present the final project.',
                                context);
                          },
                          tileBorderColor: selectedGoal ==
                                  'complete and present the final project.'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedGoal ==
                                  'complete and present the final project.'
                              ? secondaryColor
                              : trans,
                          title: 'complete and present the final project.',
                        ),
                        sixteenVerticalSpace,
                        Text(
                          'Career growth & progress',
                          style: tTextStyle500.copyWith(
                              fontSize: 14, color: iconColor),
                        ),
                        eightVerticalSpace,
                        _optionTile(
                          onTap: () {
                            setState(() {
                              selectedGoal =
                                  'Work towards obtaining certifications that are valuable';
                            });
                            _taskState.getSelectedGoal(
                                'Work towards obtaining certifications that are valuable',
                                context);
                          },
                          tileBorderColor: selectedGoal ==
                                  'Work towards obtaining certifications that are valuable'
                              ? secondaryColor
                              : borderColor,
                          circleColor: selectedGoal ==
                                  'Work towards obtaining certifications that are valuable'
                              ? secondaryColor
                              : trans,
                          title:
                              'Work towards obtaining certifications that are valuable',
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
