import 'package:TaskRM/providers/task_goal_time_tracking_provider.dart';
import 'package:TaskRM/utils/constant/constant.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';

class TimeInputBottomSheet extends StatefulWidget {
  final String docType;
  final String taskId;
  final String goalId;

  const TimeInputBottomSheet({
    Key? key,
    required this.docType,
    required this.taskId,
    required this.goalId,
  }) : super(key: key);

  @override
  State<TimeInputBottomSheet> createState() => _TimeInputBottomSheetState();
}

class _TimeInputBottomSheetState extends State<TimeInputBottomSheet> {
  late bool isTimeTracking = false;
  late String _selectedHour = '';
  late String _selectedMinute = '';
  late String _startTime = '';
  late String _stopTime = '';
  final List<String> _hourList = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  final List<String> _minuteList = ['0', '15', '30', '45'];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: white),
        child: SingleChildScrollView(
          child: Consumer<TaskGoalTimeTrackingProvider>(
              builder: (_, taskGoalTimeTrackerState, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                eightVerticalSpace,
                _header(),
                eightVerticalSpace,
                const Divider(),
                sixteenVerticalSpace,
                _buildHourInput(),
                _buildMinuteInput(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    onTap: () {
                      if (_selectedHour.isNotEmpty &&
                          _selectedMinute.isNotEmpty) {
                        taskGoalTimeTrackerState.addTimeSpent(
                            widget.goalId,
                            widget.taskId,
                            _startTime,
                            _stopTime,
                            AppConstant.convertTimeToSeconds(
                                int.parse(_selectedHour),
                                int.parse(_selectedMinute)),
                            context);
                      }
                    },
                    buttonTitle: 'Submit',
                    buttonColor:
                        _selectedHour.isNotEmpty && _selectedMinute.isNotEmpty
                            ? primaryColor
                            : primaryLight,
                    isLoading: taskGoalTimeTrackerState.isTimeSpentAdding,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: iconColor,
        //     )),
        Column(
          children: [
            Text(
              'Add Time',
              style: tTextStyleRegular.copyWith(fontSize: 16, color: iconColor),
            ),
            Text(
              'Time Input',
              style: tTextStyle500.copyWith(fontSize: 20, color: black),
            ),
          ],
        ),
        // IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.clear,
        //       color: iconColor,
        //     )),
      ],
    );
  }

  Widget _buildHourInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hours',
            style:
                tTextStyle500.copyWith(color: textPrimaryColor, fontSize: 18),
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 42,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  var item = _hourList[index];
                  return _optionChip(() {
                    setState(() {
                      _selectedHour = item;
                    });
                  }, item, _selectedHour == item ? primaryColor : trans);
                },
                separatorBuilder: (_, index) => eightHorizontalSpace,
                itemCount: _hourList.length),
          ),
        ],
      ),
    );
  }

  Widget _buildMinuteInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Minutes',
            style:
                tTextStyle500.copyWith(color: textPrimaryColor, fontSize: 18),
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 42,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  var item = _minuteList[index];
                  return _optionChip(() {
                    setState(() {
                      _selectedMinute = item;
                    });
                  }, item, _selectedMinute == item ? primaryColor : trans);
                },
                separatorBuilder: (_, index) => eightHorizontalSpace,
                itemCount: _minuteList.length),
          ),
        ],
      ),
    );
  }

  Widget _optionChip(VoidCallback onTap, String value, Color chipBorderColor) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: chipBorderColor),
            color: textFieldFillColor),
        child: Text(
          value,
          style: tTextStyleRegular.copyWith(
              fontSize: 14, color: const Color(0xFF555555)),
        ),
      ),
    );
  }
}
