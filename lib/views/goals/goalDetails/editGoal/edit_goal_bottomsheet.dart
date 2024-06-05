import 'package:TaskRM/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/goals/select_parent_goal_bottomsheet.dart';
import '../../../../models/goal.dart';
import '../../../../providers/goals_provider.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';

class EditGoalBottomSheet extends StatefulWidget {
  final Goal goal;

  const EditGoalBottomSheet({
    Key? key,
    required this.goal,
  }) : super(key: key);

  @override
  State<EditGoalBottomSheet> createState() => _EditGoalBottomSheetState();
}

class _EditGoalBottomSheetState extends State<EditGoalBottomSheet> {
  late String selectedType = widget.goal.type;
  late final TextEditingController _titleController =
      TextEditingController(text: widget.goal.title);
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.goal.description);

  @override
  void initState() {
    final goalState = Provider.of<GoalProvider>(context, listen: false);
    goalState.getSelectedParentGoal(widget.goal.parentGoal, true, context);
    super.initState();
  }

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
          child: Consumer<GoalProvider>(builder: (_, _goalState, child) {
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
            'Edit Goal',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          InkWell(
            onTap: () async {
              await goalState.editGoal(widget.goal.id, _titleController.text,
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
              child: goalState.isGoalEditing
                  ? const SizedBox(
                      height: 16, width: 16, child: CircularProgressIndicator())
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
            CustomDialog.bottomSheet(
                context,
                SelectParentGoalBottomSheet(
                  parentGoal: widget.goal.parentGoal,
                ));
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
                      AppConstant.convertParentGoal(goalState.selectedParentGoal),
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
