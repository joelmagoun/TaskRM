import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/custom_snack.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/newTask/select_goal_bottom_sheet.dart';
import '../../../../models/task.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final Task task;

  const EditTaskBottomSheet({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  late String selectedTime = widget.task.timeframe;
  late String selectedType = widget.task.type;
  late String selectedPriority = widget.task.priority;
  late final TextEditingController _titleController = TextEditingController(
      text: widget.task.title);
  late final TextEditingController _descriptionController = TextEditingController(
      text: widget.task.description);

  @override
  void initState() {
    final taskState = Provider.of<TaskProvider>(context, listen: false);
    taskState.getSelectedGoal( widget.task.goal, widget.task.goalId ?? '', context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 1.2,
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
            'Edit Task',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          InkWell(
            onTap: () async {
              await taskState.editTask(
                  widget.task.id,
                  _titleController.text,
                  selectedType,
                  taskState.selectedGoalId,
                  selectedPriority,
                  selectedTime,
                  _descriptionController.text,
                  taskState.selectedGoal,
                  context);
            },
            child: Container(
              height: 40,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryColor,
              ),
              child: taskState.isTaskEditing
                  ? const CircularProgressIndicator()
                  : Text(
                'Save',
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
          'Priority',
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
          'Timeframe',
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
              taskState.getSelectedGoal( widget.task.goal, widget.task.goalId!, context);
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.4,
                    child: Text(
                      taskState.selectedGoal,
                     // widget.task.goal,
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.4,
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
