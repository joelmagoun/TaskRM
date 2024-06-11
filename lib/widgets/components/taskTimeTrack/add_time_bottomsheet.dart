import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/widgets/components/taskTimeTrack/time_input_bottomsheet.dart';
import 'package:TaskRM/widgets/components/taskTimeTrack/time_tracker_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../providers/task_goal_time_tracking_provider.dart';
import '../../../utils/assets_path.dart';

class AddTimeBottomSheet extends StatefulWidget {
  final String docType;
  final String taskId;
  final String goalId;

  const AddTimeBottomSheet({
    Key? key,
    required this.docType,
    required this.taskId,
    required this.goalId,
  }) : super(key: key);

  @override
  State<AddTimeBottomSheet> createState() => _AddTimeBottomSheetState();
}

class _AddTimeBottomSheetState extends State<AddTimeBottomSheet> {
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _optionTile(context, () {
                        CustomDialog.bottomSheet(
                            context, TimeTrackerBottomSheet(
                            docType: widget.docType,
                            taskId: widget.taskId,
                            goalId: widget.goalId
                        ));
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => StopWatchPage()));
                      },
                          stopWatchIcon,
                          'Time tracker',
                          'Tap \'Start\' to begin your task and \'Stop\' when finished or pausing progress.',
                          true),
                      sixteenVerticalSpace,
                      _optionTile(context, () {
                        CustomDialog.bottomSheet(
                            context,
                            TimeInputBottomSheet(
                                docType: widget.docType,
                                taskId: widget.taskId,
                                goalId: widget.goalId));
                      },
                          editOutlineIcon,
                          'Time input',
                          'Enter the approximate amount of time you\'ve dedicated to your task.',
                          false),
                    ],
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
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear,
              color: trans,
            )),
        Text(
          'Add Time',
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

  Widget _optionTile(BuildContext context, VoidCallback onTap, String icon,
      String title, String subTitle, bool isTimeTrack) {
    final taskGoalTimeTrackerState =
        Provider.of<TaskGoalTimeTrackingProvider>(context, listen: false);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: textFieldFillColor
            //color: const Color(0xFFF0F1F8),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      isTimeTrack
                          ? Stack(children: [
                              SvgPicture.asset(stopWatchIcon),
                        Positioned(
                                  top: 20,
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor:
                                    taskGoalTimeTrackerState.isTimeTracking
                                            ? const Color(0xFF19E8C3)
                                            : trans,
                                  ))
                            ])
                          : SvgPicture.asset(editOutlineIcon),
                      eightHorizontalSpace,
                      Text(
                        title,
                        style: tTextStyle500.copyWith(
                            color: textPrimaryColor, fontSize: 16),
                      )
                    ],
                  ),
                  eightVerticalSpace,
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      subTitle,
                      style: tTextStyleRegular.copyWith(
                          color: const Color(0xFF555555)),
                    ),
                  )
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
