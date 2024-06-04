import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/constant/constant.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/taskQueue/widgets/filter_option_tile.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../providers/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskQueueFilterBottomSheet extends StatefulWidget {
  const TaskQueueFilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskQueueFilterBottomSheet> createState() =>
      _TaskQueueFilterBottomSheetState();
}

class _TaskQueueFilterBottomSheetState
    extends State<TaskQueueFilterBottomSheet> {

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
          child: Consumer<TaskProvider>(builder: (_, taskState, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                eightVerticalSpace,
                _header(),
                eightVerticalSpace,
                const Divider(),
                _allInfo()
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
          AppLocalizations.of(context)!.filters,
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
          /// time frame ///
          Text(
            AppLocalizations.of(context)!.timeframe,
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                var time = AppConstant.timeFrameList[index];
                return FilterOptionTile(
                    onTap: () {
                      taskState.getQueueFilterTimeType(
                          taskState.selectedQueueType, time);
                    },
                    title: time,
                    checkBoxColor: taskState.selectedQueueTimeFrame == time
                        ? primaryColor
                        : white,
                    boxBorderColor: taskState.selectedQueueTimeFrame == time
                        ? trans
                        : secondaryColor);
              },
              separatorBuilder: (_, index) => sixteenVerticalSpace,
              itemCount: AppConstant.timeFrameList.length),

          /// work type ///
          Text(
            AppLocalizations.of(context)!.type,
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                var type = AppConstant.typeList[index];
                return FilterOptionTile(
                    onTap: () {
                      taskState.getQueueFilterTimeType(
                          type, taskState.selectedQueueTimeFrame);
                    },
                    title: type,
                    checkBoxColor: taskState.selectedQueueType == type
                        ? primaryColor
                        : white,
                    boxBorderColor: taskState.selectedQueueType == type
                        ? trans
                        : secondaryColor);
              },
              separatorBuilder: (_, index) => sixteenVerticalSpace,
              itemCount: AppConstant.typeList.length),

          PrimaryButton(
            onTap: () async {
              await taskState.getAllTaskList();
              Navigator.pop(context);
            },
            buttonTitle: AppLocalizations.of(context)!.apply,
            buttonColor: taskState.selectedQueueTimeFrame == '' &&
                    taskState.selectedQueueType == ''
                ? primaryLight
                : primaryColor,
          ),
          primaryVerticalSpace
        ],
      ),
    );
  }
}
