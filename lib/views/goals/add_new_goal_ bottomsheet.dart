import 'package:TaskRM/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/goals/select_parent_goal_bottomsheet.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../providers/goals_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/custom_snack.dart';
import '../tasks/newTask/select_goal_bottom_sheet.dart';

class AddNewGoalBottomSheet extends StatefulWidget {
  const AddNewGoalBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewGoalBottomSheet> createState() => _AddNewGoalBottomSheetState();
}

class _AddNewGoalBottomSheetState extends State<AddNewGoalBottomSheet> {
  late String selectedType = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.2,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: white),
        child: SingleChildScrollView(
          child: Consumer<GoalProvider>(builder: (_, goalState, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _header(context),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _titleField(),
                      _typeField(),
                      _descriptionField(),
                      _goalField(),
                      const SizedBox(
                        height: 48,
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.clear,
                color: iconColor,
              )),
          Text(
            AppLocalizations.of(context)!.newgoal,
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          InkWell(
            onTap: () async {
              await goalState.addNewGoal(_titleController.text,
                  _descriptionController.text, selectedType, context);
            },
            child: Container(
              height: 40,
              width: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryColor,
              ),
              child: goalState.isGoalAdding
                  ? const SizedBox(
                      height: 16, width: 16, child: CircularProgressIndicator())
                  : Text(
                      AppLocalizations.of(context)!.add,
                      style:
                          tTextStyleBold.copyWith(color: white, fontSize: 16),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.title,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              contentPadding: const EdgeInsets.all(12),
              hintText: AppLocalizations.of(context)!.learnnewskill,
              hintStyle: hintTextStyle,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor),
              ),
              focusColor: primaryColor,
            ))
      ],
    );
  }

  Widget _typeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          AppLocalizations.of(context)!.type,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = '1';
              });
            },
            tileBorderColor: selectedType == '1' ? borderColor : trans,
            circleColor: selectedType == '1' ? secondaryColor : trans,
            title: AppLocalizations.of(context)!.work),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = '2';
              });
            },
            tileBorderColor: selectedType == '2' ? borderColor : trans,
            circleColor: selectedType == '2' ? secondaryColor : trans,
            title: AppLocalizations.of(context)!.personalproject),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = '3';
              });
            },
            tileBorderColor: selectedType == '3' ? borderColor : trans,
            circleColor: selectedType == '3' ? secondaryColor : trans,
            title: AppLocalizations.of(context)!.self),
      ],
    );
  }

  Widget _descriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          AppLocalizations.of(context)!.description,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        TextFormField(
            controller: _descriptionController,
            maxLines: 6,
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              contentPadding: const EdgeInsets.all(12),
              hintText:
                  AppLocalizations.of(context)!.descriptiontxt,
              hintStyle: hintTextStyle,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor),
              ),
              focusColor: primaryColor,
            ))
      ],
    );
  }

  Widget _goalField() {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          AppLocalizations.of(context)!.parentgoal,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        TextFormField(
            controller: TextEditingController(text: goalState.selectedParentGoal),
            readOnly: true,
            onTap: () {
              if (selectedType != '') {
                goalState.getFilterType(selectedType);
                goalState.getGoalList();
                CustomDialog.bottomSheet(
                    context, SelectParentGoalBottomSheet(type: selectedType));
               // taskState.getSelectedGoal('', '', context);
              } else {
                CustomSnack.warningSnack(AppLocalizations.of(context)!.selecttasktype, context);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              contentPadding: const EdgeInsets.all(12),
              hintText: AppLocalizations.of(context)!.selectgoal,
              hintStyle: hintTextStyle,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: iconColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor),
              ),
              focusColor: primaryColor,
            )),
        // InkWell(
        //   onTap: () {
        //     // CustomDialog.bottomSheet(
        //     //     context,
        //     //     const SelectParentGoalBottomSheet(
        //     //       parentGoal: '',
        //     //     ));
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       border: Border.all(color: borderColor),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           SizedBox(
        //             width: MediaQuery.of(context).size.width / 1.4,
        //             child: Text(
        //               AppConstant.convertParentGoal(
        //                   goalState.selectedParentGoal),
        //               maxLines: 2,
        //               overflow: TextOverflow.ellipsis,
        //               style: tTextStyleRegular.copyWith(
        //                   fontSize: 16, color: black),
        //             ),
        //           ),
        //           const Icon(
        //             Icons.keyboard_arrow_down_outlined,
        //             color: iconColor,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
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
          padding: const EdgeInsets.all(8.0),
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
