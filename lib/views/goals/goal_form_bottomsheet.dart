import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/models/goal.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/views/goals/select_parent_goal_bottomsheet.dart';
import 'package:TaskRM/utils/custom_snack.dart';
// ... other imports


class GoalFormBottomSheet extends StatefulWidget {
  final Goal? goal; // null for add, existing goal for edit

  const GoalFormBottomSheet({
    Key? key,
    this.goal,
  }) : super(key: key);

  @override
  State<GoalFormBottomSheet> createState() => _GoalFormBottomSheetState();
}

class _GoalFormBottomSheetState extends State<GoalFormBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String selectedType;
  bool get isEditing => widget.goal != null;

  @override
  void initState() {
    super.initState();
    // Initialize with existing data for edit, empty for add
    _titleController = TextEditingController(text: widget.goal?.title ?? '');
    _descriptionController = TextEditingController(text: widget.goal?.description ?? '');
    selectedType = widget.goal?.type ?? '';

    if (isEditing) {
      // Set parent goal for edit mode
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final goalProvider = Provider.of<GoalProvider>(context, listen: false);
        if (widget.goal?.parentGoal != null && widget.goal?.parentGoal != '0') {
          goalProvider.getParentGoalTitle(widget.goal?.parentGoal).then((title) {
            goalProvider.setSelectedParentGoal(
              widget.goal?.parentGoal ?? '',
              title,
            );
          });
        }
      });
    }
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
            child: Consumer<GoalProvider>(
              builder: (_, goalState, __) {
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
    final goalState = Provider.of<GoalProvider>(context, listen: false);
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
            isEditing ? 'Edit Goal' : 'New Goal',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          InkWell(
            onTap: () async {
              if (isEditing) {
                await goalState.updateGoal(
                  goalId: widget.goal!.id,
                  title: _titleController.text,
                  type: selectedType,
                  description: _descriptionController.text,
                  parentGoalId: goalState.selectedParentGoalId,
                  context: context,
                );
              } else {
                await goalState.addNewGoal(
                  _titleController.text,
                  selectedType,
                  _descriptionController.text,
                  context,
                );
              }
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
              hintText: 'Learn New Skill',
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
              hintText:
              'Contribute insights, updates, and ideas crucial for team synergy ...',
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
          'Parent Goal',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        eightVerticalSpace,
        InkWell(
          onTap: () {
            if (selectedType.isNotEmpty) {
              goalState.getFilterType(selectedType);
              goalState.getParentGoalsList();  // This will now use the filtered type
              CustomDialog.bottomSheet(
                context, 
                const SelectParentGoalBottomSheet()
              );
            } else {
              CustomSnack.warningSnack('Please select goal type first.', context);
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
                    child: Consumer<GoalProvider>(
                      builder: (context, goalState, child) {
                        return Text(
                          goalState.selectedParentGoalTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: tTextStyleRegular.copyWith(
                            fontSize: 16, 
                            color: goalState.selectedParentGoalTitle == 'Select' 
                                ? hintTextColor 
                                : black
                          ),
                        );
                      },
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
  // ... Rest of the widget methods remain the same
} 