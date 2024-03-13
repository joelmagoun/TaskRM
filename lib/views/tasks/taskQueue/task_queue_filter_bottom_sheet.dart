import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/taskQueue/widgets/filter_option_tile.dart';
import 'package:task_rm/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../providers/goals_provider.dart';
import '../../../providers/task_provider.dart';

class TaskQueueFilterBottomSheet extends StatefulWidget {
  const TaskQueueFilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskQueueFilterBottomSheet> createState() => _TaskQueueFilterBottomSheetState();
}

class _TaskQueueFilterBottomSheetState extends State<TaskQueueFilterBottomSheet> {
  late String selectedTime = '';
  late String selectedType = '';

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
              eightVerticalSpace,
              _header(),
              eightVerticalSpace,
              const Divider(),
              _allInfo()
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear,
              color: trans,
            )),
        Text(
          'Filters',
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
    );
  }

  Widget _allInfo() {

    final taskState = Provider.of<TaskProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeframe',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Today';
              });
            },
            title: 'Today',
            checkBoxColor: selectedTime == 'Today' ? primaryColor : white,
            boxBorderColor: selectedTime == 'Today' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedTime = '3 days';
              });
            },
            title: '3 days',
            checkBoxColor: selectedTime == '3 days' ? primaryColor : white,
            boxBorderColor: selectedTime == '3 days' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Week';
              });
            },
            title: 'Week',
            checkBoxColor: selectedTime == 'Week' ? primaryColor : white,
            boxBorderColor: selectedTime == 'Week' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Fortnight';
              });
            },
            title: 'Fortnight',
            checkBoxColor: selectedTime == 'Fortnight' ? primaryColor : white,
            boxBorderColor:
                selectedTime == 'Fortnight' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Month';
              });
            },
            title: 'Month',
            checkBoxColor: selectedTime == 'Month' ? primaryColor : white,
            boxBorderColor: selectedTime == 'Month' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedTime = '90 days';
              });
            },
            title: '90 days',
            checkBoxColor: selectedTime == '90 days' ? primaryColor : white,
            boxBorderColor: selectedTime == '90 days' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedTime = 'Year';
              });
            },
            title: 'Year',
            checkBoxColor: selectedTime == 'Year' ? primaryColor : white,
            boxBorderColor: selectedTime == 'Year' ? trans : secondaryColor,
          ),
          const SizedBox(
            height: 48,
          ),
          Text(
            'Type',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedType = 'Work';
              });
            },
            title: 'Work',
            checkBoxColor: selectedType == 'Work' ? primaryColor : white,
            boxBorderColor: selectedType == 'Work' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedType = 'Personal Project';
              });
            },
            title: 'Personal Project',
            checkBoxColor:
                selectedType == 'Personal Project' ? primaryColor : white,
            boxBorderColor:
                selectedType == 'Personal Project' ? trans : secondaryColor,
          ),
          sixteenVerticalSpace,
          FilterOptionTile(
            onTap: () {
              setState(() {
                selectedType = 'Self';
              });
            },
            title: 'Self',
            checkBoxColor: selectedType == 'Self' ? primaryColor : white,
            boxBorderColor: selectedType == 'Self' ? trans : secondaryColor,
          ),
          const SizedBox(
            height: 48,
          ),
          PrimaryButton(
            onTap: () async {
              taskState.getQueueFilterTimeType(selectedType, selectedTime);
              await taskState.getAllTaskList();
              Navigator.pop(context);
            },
            buttonTitle: 'Apply',
            buttonColor: selectedTime == '' && selectedType == ''
                ? primaryLight
                : primaryColor,
          ),
          primaryVerticalSpace
        ],
      ),
    );
  }

}