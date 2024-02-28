import 'package:flutter/material.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/typograpgy.dart';
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
  late String selectedGoal = 'Select';

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _header(),
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
                      height: 32,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
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
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Add',
                  style: tTextStyleBold.copyWith(color: white, fontSize: 16),
                ),
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
            CustomDialog.bottomSheet(context, _selectGoalBottomSheet());
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
                  Text(
                    selectedGoal,
                    style:
                        tTextStyleRegular.copyWith(fontSize: 16, color: black),
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

  Widget _selectGoalBottomSheet() {
    return Material(
        color: Colors.transparent,
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24), topLeft: Radius.circular(24)),
              color: white),
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
                      style: tTextStyle500.copyWith(fontSize: 20, color: black),
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
                child: Column(children: [
                  _optionTile(
                      onTap: () {
                        setState(() {
                          selectedGoal = 'None';
                        });
                      },
                      tileBorderColor:
                      selectedGoal == 'None' ? secondaryColor : borderColor,
                      circleColor: selectedGoal == 'None' ? secondaryColor : trans,
                      title: 'None',
                  ),
                  sixteenVerticalSpace,
                  _optionTile(
                    onTap: () {
                      setState(() {
                        selectedGoal = 'Attend 6 of networking events within the industry in the';
                      });
                    },
                    tileBorderColor:
                    selectedGoal == 'Attend 6 of networking events within the industry in the' ? secondaryColor : borderColor,
                    circleColor: selectedGoal == 'Attend 6 of networking events within the industry in the' ? secondaryColor : trans,
                    title: 'Attend 6 of networking events within the industry in the',
                  ),
                ],),
              )
            ],
          ),
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
