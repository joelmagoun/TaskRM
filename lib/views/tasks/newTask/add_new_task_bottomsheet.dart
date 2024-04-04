import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/goals_provider.dart';
import 'package:task_rm/providers/task_provider.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/custom_snack.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/newTask/select_goal_bottom_sheet.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';

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
          child: Consumer<TaskProvider>(builder: (_, _taskState, child) {
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
    final _taskState = Provider.of<TaskProvider>(context, listen: false);
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
            'New Task',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          InkWell(
            onTap: () async {
              var expected =
                  _taskState.getExpectedDateFromTimeframe(selectedTime);
              print('alkdjfalkdj $expected');

              if (selectedType != null &&
                  selectedPriority != null &&
                  selectedTime != null &&
                  _titleController.text.trim().isNotEmpty &&
                  _descriptionController.text.trim().isNotEmpty &&
                  _taskState.selectedGoal.trim().isNotEmpty) {
                await _taskState.addNewTask(
                    _titleController.text,
                    selectedType,
                    _taskState.selectedGoalId,
                    selectedPriority,
                    selectedTime,
                    _descriptionController.text,
                    _taskState.selectedGoal,
                    context);
              } else {
                CustomDialog.autoDialog(context, Icons.warning,
                    'Please select all required information.');
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
              child: _taskState.isTaskAdding
                  ? const CircularProgressIndicator()
                  : Text(
                      'Add',
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
          'Title',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              contentPadding: const EdgeInsets.all(12),
              hintText: 'Schedule Team Meeting',
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
          'Type',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = 'Work';
              });
            },
            tileBorderColor: selectedType == 'Work' ? borderColor : trans,
            circleColor: selectedType == 'Work' ? secondaryColor : trans,
            title: 'Work'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = 'Personal Project';
              });
            },
            tileBorderColor:
                selectedType == 'Personal Project' ? borderColor : trans,
            circleColor:
                selectedType == 'Personal Project' ? secondaryColor : trans,
            title: 'Personal Project'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedType = 'Self';
              });
            },
            tileBorderColor: selectedType == 'Self' ? borderColor : trans,
            circleColor: selectedType == 'Self' ? secondaryColor : trans,
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
          'Priority',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedPriority = 'Needs to be done';
              });
            },
            tileBorderColor:
                selectedPriority == 'Needs to be done' ? borderColor : trans,
            circleColor:
                selectedPriority == 'Needs to be done' ? secondaryColor : trans,
            title: 'Needs to be done'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedPriority = 'Nice to have';
              });
            },
            tileBorderColor:
                selectedPriority == 'Nice to have' ? borderColor : trans,
            circleColor:
                selectedPriority == 'Nice to have' ? secondaryColor : trans,
            title: 'Nice to have'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedPriority = 'Nice idea';
              });
            },
            tileBorderColor:
                selectedPriority == 'Nice idea' ? borderColor : trans,
            circleColor:
                selectedPriority == 'Nice idea' ? secondaryColor : trans,
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
          'Timeframe',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = 'None';
              });
            },
            tileBorderColor: selectedTime == 'None' ? borderColor : trans,
            circleColor: selectedTime == 'None' ? secondaryColor : trans,
            title: 'None'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Today';
              });
            },
            tileBorderColor: selectedTime == 'Today' ? borderColor : trans,
            circleColor: selectedTime == 'Today' ? secondaryColor : trans,
            title: 'Today'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '3 days';
              });
            },
            tileBorderColor: selectedTime == '3 days' ? borderColor : trans,
            circleColor: selectedTime == '3 days' ? secondaryColor : trans,
            title: '3 days'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Week';
              });
            },
            tileBorderColor: selectedTime == 'Week' ? borderColor : trans,
            circleColor: selectedTime == 'Week' ? secondaryColor : trans,
            title: 'Week'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Fortnight';
              });
            },
            tileBorderColor: selectedTime == 'Fortnight' ? borderColor : trans,
            circleColor: selectedTime == 'Fortnight' ? secondaryColor : trans,
            title: 'Fortnight'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Month';
              });
            },
            tileBorderColor: selectedTime == 'Month' ? borderColor : trans,
            circleColor: selectedTime == 'Month' ? secondaryColor : trans,
            title: 'Month'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = '90 days';
              });
            },
            tileBorderColor: selectedTime == '90 days' ? borderColor : trans,
            circleColor: selectedTime == '90 days' ? secondaryColor : trans,
            title: '90 days'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Year';
              });
            },
            tileBorderColor: selectedTime == 'Year' ? borderColor : trans,
            circleColor: selectedTime == 'Year' ? secondaryColor : trans,
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
          'Description',
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
              hintText: 'Enter the description of the task',
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
          'Goal',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        InkWell(
          onTap: () {
            if (selectedType != '') {
              goalState.getFilterType(selectedType);
              goalState.getGoalList();
              CustomDialog.bottomSheet(
                  context, SelectGoalBottomSheet(type: selectedType));
              taskState.getSelectedGoal('Select', '', context);
            } else {
              CustomSnack.warningSnack('Please select task type.', context);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      taskState.selectedGoal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: tTextStyleRegular.copyWith(
                          fontSize: 16, color: black),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: iconColor,
                  )
                ],
              ),
            ),
          ),
        )
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
