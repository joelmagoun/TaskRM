import 'package:TaskRM/providers/task_goal_time_tracking_provider.dart';
import 'package:TaskRM/utils/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../utils/assets_path.dart';
import '../../../utils/constant/constant.dart';

class TimeTrackerBottomSheet extends StatefulWidget {
  final String docType;
  final String taskId;
  final String goalId;

  const TimeTrackerBottomSheet({
    Key? key,
    required this.docType,
    required this.taskId,
    required this.goalId,
  }) : super(key: key);

  @override
  State<TimeTrackerBottomSheet> createState() => _TimeTrackerBottomSheetState();
}

class _TimeTrackerBottomSheetState extends State<TimeTrackerBottomSheet> {
  late String _startTime = '';
  late String _stopTime = '';
  late String hours = '0';
  late String minutes = '0';

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  String _formatHours(int milliseconds) {
    final int hours = milliseconds ~/ (1000 * 60 * 60);
    return '$hours';
  }

  String _formatMinutes(int milliseconds) {
    final int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    return '$minutes';
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _stopWatchTimer.dispose();
  // }

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
                primaryVerticalSpace,
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snapshot) {
                    final value = snapshot.data!;
                    // final displayTime = StopWatchTimer.getDisplayTime(value);
                    hours = _formatHours(value);
                    minutes = _formatMinutes(value);
                    return RichText(
                      text: TextSpan(
                        text: hours,
                        style: tTextStyleRegular.copyWith(
                            color: textPrimaryColor, fontSize: 48),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Hr : ',
                              style: tTextStyleRegular.copyWith(
                                  fontSize: 40, color: iconColor)),
                          TextSpan(
                              text: minutes,
                              style: tTextStyleRegular.copyWith(
                                  color: textPrimaryColor, fontSize: 48)),
                          TextSpan(
                              text: ' M',
                              style: tTextStyleRegular.copyWith(
                                  fontSize: 40, color: iconColor)),
                        ],
                      ),
                    );
                  },
                ),
                primaryVerticalSpace,
                taskGoalTimeTrackerState.isTimeTracking
                    ? InkWell(
                        onTap: () {
                          _stopWatchTimer.onStopTimer();
                          taskGoalTimeTrackerState.getTimeTrackingStatus(false);
                          setState(() {
                            _stopTime = DateTime.now().toString();
                          });
                          taskGoalTimeTrackerState.addTimeSpent(
                              widget.goalId,
                              widget.taskId,
                              _startTime,
                              _stopTime,
                              AppConstant.convertTimeToSeconds(
                                  int.parse(hours), int.parse(minutes)),
                              context);
                        },
                        child: SvgPicture.asset(stopTrackingIcon))
                    : InkWell(
                        onTap: () {
                          _stopWatchTimer.onStartTimer();
                          taskGoalTimeTrackerState.getTimeTrackingStatus(true);
                          setState(() {
                            _startTime = DateTime.now().toString();
                          });
                          CustomSnack.successSnack(
                              'Time tracking started.', context);
                        },
                        child: SvgPicture.asset(startTrackingIcon)),
                eightVerticalSpace,
                Text(
                  taskGoalTimeTrackerState.isTimeTracking
                      ? 'Stop Tracking'
                      : 'Start Tracking',
                  style: tTextStyle500.copyWith(
                      fontSize: 16, color: textPrimaryColor),
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
    final taskGoalTimeTrackerState =
        Provider.of<TaskGoalTimeTrackingProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: iconColor,
            )),
        Column(
          children: [
            Text(
              'Add Time',
              style: tTextStyleRegular.copyWith(fontSize: 16, color: iconColor),
            ),
            Row(
              children: [
                Text(
                  'Time Tracker',
                  style: tTextStyle500.copyWith(fontSize: 20, color: black),
                ),
                const SizedBox(
                  width: 4,
                ),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: taskGoalTimeTrackerState.isTimeTracking
                      ? const Color(0xFF19E8C3)
                      : trans,
                )
              ],
            )
          ],
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
}
