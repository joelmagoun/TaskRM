import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/widgets/empty_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/spacer.dart';
import '../../../utils/typograpgy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectGoalBottomSheet extends StatefulWidget {
  final String type;

  const SelectGoalBottomSheet({Key? key, required this.type}) : super(key: key);

  @override
  State<SelectGoalBottomSheet> createState() => _SelectGoalBottomSheetState();
}

class _SelectGoalBottomSheetState extends State<SelectGoalBottomSheet> {
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
          child: Consumer2<GoalProvider, TaskProvider>(
              builder: (_, goalState, taskState, child) {
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
                        AppLocalizations.of(context)!.selectgoal,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: goalState.allParentGoalList.isEmpty
                        ? EmptyWidget(
                            icon: goalIcon, title: AppLocalizations.of(context)!.sorry, subTitle: AppLocalizations.of(context)!.nomatchinggoalstt)
                        : ListView.separated(
                            itemBuilder: (_, index) {
                              var item = goalState.allParentGoalList[index];
                              return _optionTile(
                                  onTap: () {

                                    setState(() {
                                      selectedGoal = item.title;
                                    });
                                    taskState.getSelectedGoal(
                                        item.title, item.id, context);
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
