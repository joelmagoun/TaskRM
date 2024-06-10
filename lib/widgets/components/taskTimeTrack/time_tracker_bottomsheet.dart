import 'package:TaskRM/utils/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../utils/assets_path.dart';

class TimeTrackerBottomSheet extends StatefulWidget {
  const TimeTrackerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeTrackerBottomSheet> createState() => _TimeTrackerBottomSheetState();
}

class _TimeTrackerBottomSheetState extends State<TimeTrackerBottomSheet> {
  late bool isTimeTracking = false;

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

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

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
          child: Consumer<TaskProvider>(builder: (_, taskState, child) {
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
                    final hours = _formatHours(value);
                    final minutes = _formatMinutes(value);
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
                isTimeTracking
                    ? InkWell(
                        onTap: () {
                          _stopWatchTimer.onStopTimer();
                          setState(() {
                            isTimeTracking = false;
                          });
                        },
                        child: SvgPicture.asset(stopTrackingIcon))
                    : InkWell(
                        onTap: () {
                          _stopWatchTimer.onStartTimer();
                          setState(() {
                            isTimeTracking = true;
                          });
                          CustomSnack.successSnack('Time tracking started.', context);
                        },
                        child: SvgPicture.asset(startTrackingIcon)),
                eightVerticalSpace,
                Text(
                  isTimeTracking ? 'Stop Tracking' : 'Start Tracking',
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
                  backgroundColor:
                      isTimeTracking ? const Color(0xFF19E8C3) : trans,
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
