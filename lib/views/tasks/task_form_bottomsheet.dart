import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/models/task.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/custom_snack.dart';
import 'package:TaskRM/views/tasks/newTask/select_goal_bottom_sheet.dart';

class TaskFormBottomSheet extends StatefulWidget {
  final Task? task; // null for add, existing task for edit

  const TaskFormBottomSheet({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<TaskFormBottomSheet> createState() => _TaskFormBottomSheetState();
}

class _TaskFormBottomSheetState extends State<TaskFormBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String selectedType;
  late String selectedPriority;
  late String selectedTimeframe;
  bool get isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    // Initialize with existing data for edit, empty for add
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    selectedType = widget.task?.type ?? '';
    selectedPriority = widget.task?.priority ?? '';
    selectedTimeframe = widget.task?.timeframe ?? '';

    if (isEditing) {
      // Set goal for edit mode if needed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        if (widget.task?.goal != null && widget.task?.goal != '0') {
          // Initialize goal selection if needed
          // Similar to how we handle parent goals in GoalFormBottomSheet
        }
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 40.0,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.2,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            color: white,
          ),
          child: SingleChildScrollView(
            child: Consumer<TaskProvider>(
              builder: (_, taskState, __) {
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
                          const SizedBox(height: 48),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.clear, color: iconColor),
          ),
          Text(
            isEditing ? 'Edit Task' : 'New Task',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          InkWell(
            onTap: () async {
              if (_validateForm()) {
                if (isEditing) {
                  await taskState.updateTask(
                    taskId: widget.task!.id.toString(),
                    title: _titleController.text,
                    type: selectedType,
                    priority: selectedPriority,
                    timeframe: selectedTimeframe,
                    description: _descriptionController.text,
                    context: context,
                  );
                } else {
                  await taskState.addNewTask(
                    _titleController.text,
                    selectedType,
                    taskState.selectedGoalId,
                    selectedPriority,
                    selectedTimeframe,
                    _descriptionController.text,
                    taskState.selectedGoal,
                    context,
                  );
                }
              }
            },
            child: Container(
              height: 40,
              width: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _isFormValid() ? primaryColor : primaryLight,
              ),
              child: taskState.isTaskAdding
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(white),
                      ),
                    )
                  : Text(
                      isEditing ? 'Save' : 'Add',
                      style: tTextStyleBold.copyWith(
                        color: white,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isFormValid() {
    return _titleController.text.isNotEmpty &&
        selectedType.isNotEmpty &&
        selectedPriority.isNotEmpty &&
        selectedTimeframe.isNotEmpty;
  }

  bool _validateForm() {
    if (!_isFormValid()) {
      CustomSnack.warningSnack('Please fill in all required fields', context);
      return false;
    }
    return true;
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
                selectedTimeframe = 'None';
              });
            },
            tileBorderColor: selectedTimeframe == 'None' ? borderColor : trans,
            circleColor: selectedTimeframe == 'None' ? secondaryColor : trans,
            title: 'None'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTimeframe = 'Today';
              });
            },
            tileBorderColor: selectedTimeframe == 'Today' ? borderColor : trans,
            circleColor: selectedTimeframe == 'Today' ? secondaryColor : trans,
            title: 'Today'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTimeframe = '3 days';
              });
            },
            tileBorderColor: selectedTimeframe == '3 days' ? borderColor : trans,
            circleColor: selectedTimeframe == '3 days' ? secondaryColor : trans,
            title: '3 days'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTimeframe = 'Week';
              });
            },
            tileBorderColor: selectedTimeframe == 'Week' ? borderColor : trans,
            circleColor: selectedTimeframe == 'Week' ? secondaryColor : trans,
            title: 'Week'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTimeframe = 'Fortnight';
              });
            },
            tileBorderColor: selectedTimeframe == 'Fortnight' ? borderColor : trans,
            circleColor: selectedTimeframe == 'Fortnight' ? secondaryColor : trans,
            title: 'Fortnight'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTimeframe = 'Month';
              });
            },
            tileBorderColor: selectedTimeframe == 'Month' ? borderColor : trans,
            circleColor: selectedTimeframe == 'Month' ? secondaryColor : trans,
            title: 'Month'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTimeframe = '90 days';
              });
            },
            tileBorderColor: selectedTimeframe == '90 days' ? borderColor : trans,
            circleColor: selectedTimeframe == '90 days' ? secondaryColor : trans,
            title: '90 days'),
        eightVerticalSpace,
        _optionTile(
            onTap: () {
              setState(() {
                selectedTimeframe = 'Year';
              });
            },
            tileBorderColor: selectedTimeframe == 'Year' ? borderColor : trans,
            circleColor: selectedTimeframe == 'Year' ? secondaryColor : trans,
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