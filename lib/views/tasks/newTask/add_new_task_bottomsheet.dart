import 'package:TaskRM/views/tasks/newTask/link_jira_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/custom_snack.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/newTask/select_goal_bottom_sheet.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/assets_path.dart';

class AddNewTaskBottomSheet extends StatefulWidget {
  const AddNewTaskBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewTaskBottomSheet> createState() => _AddNewTaskBottomSheetState();
}

class _AddNewTaskBottomSheetState extends State<AddNewTaskBottomSheet> {
  late String selectedTime = '';
  late String selectedType = '';
  late String selectedPriority = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  //final TextEditingController _jiraIssueController = TextEditingController();

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
          child: Consumer<TaskProvider>(builder: (_, taskState, child) {
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
                      _jiraField(),
                      _priorityField(),
                      _timeFrameField(),
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
    final taskState = Provider.of<TaskProvider>(context, listen: false);
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
            AppLocalizations.of(context)!.newtask,
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          InkWell(
            onTap: () async {
              if (selectedType != null &&
                  selectedPriority != null &&
                  selectedTime != null &&
                  _titleController.text.trim().isNotEmpty &&
                  _descriptionController.text.trim().isNotEmpty &&
                  taskState.selectedGoal.trim().isNotEmpty) {
                await taskState.addNewTask(
                    _titleController.text,
                    selectedType,
                    taskState.selectedGoalId,
                    selectedPriority,
                    selectedTime,
                    _descriptionController.text,
                    taskState.selectedGoal,
                    context);
              } else {
                CustomDialog.autoDialog(context, Icons.warning,
                    AppLocalizations.of(context)!.selectrequiredinfo);
              }
            },
            child: Container(
              height: 40,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryColor,
              ),
              child: taskState.isTaskAdding
                  ? const CircularProgressIndicator()
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
              hintText: AppLocalizations.of(context)!.titlehinttxt,
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
            title: 'Work'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = '2';
              });
            },
            tileBorderColor:
                selectedType == '2' ? borderColor : trans,
            circleColor:
                selectedType == '2' ? secondaryColor : trans,
            title: 'Personal Project'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = '3';
              });
            },
            tileBorderColor: selectedType == '3' ? borderColor : trans,
            circleColor: selectedType == '3' ? secondaryColor : trans,
            title: 'Self'),
      ],
    );
  }

  Widget _priorityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          AppLocalizations.of(context)!.priority,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedPriority = '1';
              });
            },
            tileBorderColor:
                selectedPriority == '1' ? borderColor : trans,
            circleColor:
                selectedPriority == '1' ? secondaryColor : trans,
            title: 'Needs to be done'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedPriority = '2';
              });
            },
            tileBorderColor:
                selectedPriority == '2' ? borderColor : trans,
            circleColor:
                selectedPriority == '2' ? secondaryColor : trans,
            title: 'Nice to have'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedPriority = '3';
              });
            },
            tileBorderColor:
                selectedPriority == '3' ? borderColor : trans,
            circleColor:
                selectedPriority == '3' ? secondaryColor : trans,
            title: 'Nice idea'),
      ],
    );
  }

  Widget _timeFrameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          AppLocalizations.of(context)!.timeframe,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '0';
              });
            },
            tileBorderColor: selectedTime == '0' ? borderColor : trans,
            circleColor: selectedTime == '0' ? secondaryColor : trans,
            title: 'None'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '1';
              });
            },
            tileBorderColor: selectedTime == '1' ? borderColor : trans,
            circleColor: selectedTime == '1' ? secondaryColor : trans,
            title: 'Today'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '3';
              });
            },
            tileBorderColor: selectedTime == '3' ? borderColor : trans,
            circleColor: selectedTime == '3' ? secondaryColor : trans,
            title: '3 days'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '7';
              });
            },
            tileBorderColor: selectedTime == '7' ? borderColor : trans,
            circleColor: selectedTime == '7' ? secondaryColor : trans,
            title: 'Week'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '14';
              });
            },
            tileBorderColor: selectedTime == '14' ? borderColor : trans,
            circleColor: selectedTime == '14' ? secondaryColor : trans,
            title: 'Fortnight'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '30';
              });
            },
            tileBorderColor: selectedTime == '30' ? borderColor : trans,
            circleColor: selectedTime == '30' ? secondaryColor : trans,
            title: 'Month'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '90';
              });
            },
            tileBorderColor: selectedTime == '90' ? borderColor : trans,
            circleColor: selectedTime == '90' ? secondaryColor : trans,
            title: '90 days'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '365';
              });
            },
            tileBorderColor: selectedTime == '365' ? borderColor : trans,
            circleColor: selectedTime == '365' ? secondaryColor : trans,
            title: 'Year'),
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
              hintText: AppLocalizations.of(context)!.taskdescriptionhint,
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
    final taskState = Provider.of<TaskProvider>(context, listen: false);
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          AppLocalizations.of(context)!.goal,
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        TextFormField(
            controller: TextEditingController(text:  taskState.selectedGoal),
            readOnly: true,
              onTap: () {
                if (selectedType != '') {
                  goalState.getFilterType(selectedType);
                  goalState.getGoalList();
                  CustomDialog.bottomSheet(
                      context, SelectGoalBottomSheet(type: selectedType));
                  taskState.getSelectedGoal('', '', context);
                } else {
                  CustomSnack.warningSnack('Please select task type.', context);
                }
              },
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              contentPadding: const EdgeInsets.all(12),
              hintText: 'Select Goal',
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
        //     if (selectedType != '') {
        //       goalState.getFilterType(selectedType);
        //       goalState.getGoalList();
        //       CustomDialog.bottomSheet(
        //           context, SelectGoalBottomSheet(type: selectedType));
        //       taskState.getSelectedGoal('Select', '', context);
        //     } else {
        //       CustomSnack.warningSnack('Please select task type.', context);
        //     }
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
        //               taskState.selectedGoal,
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

  Widget _jiraField() {
    final taskState = Provider.of<TaskProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Row(
          children: [
            SvgPicture.asset(jiraIcon),
            eightHorizontalSpace,
            Text(
              'Jira',
              style:
                  tTextStyle500.copyWith(fontSize: 20, color: secondaryColor),
            )
          ],
        ),
        eightVerticalSpace,
        TextFormField(
            controller: TextEditingController(text: taskState.jiraId),
            readOnly: true,
            onTap: () {
              CustomDialog.bottomSheet(context, const LinkJiraBottomSheet());
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              contentPadding: const EdgeInsets.all(12),
              hintText: 'Add Jira issue',
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
            ))
      ],
    );
  }
}
