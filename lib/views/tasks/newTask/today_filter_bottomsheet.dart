import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/constant/constant.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/taskQueue/widgets/filter_option_tile.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';

class TodayFilterBottomSheet extends StatefulWidget {
  const TodayFilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayFilterBottomSheet> createState() => _TodayFilterBottomSheetState();
}

class _TodayFilterBottomSheetState extends State<TodayFilterBottomSheet> {

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
            'Type',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                var type = AppConstant.typeList[index];
                return FilterOptionTile(
                    onTap: () {
                      taskState.getFilterType(type);
                    },
                    title: AppConstant.convertType(type),
                    checkBoxColor: taskState.selectedFilterType == type
                        ? primaryColor
                        : white,
                    boxBorderColor: taskState.selectedFilterType == type
                        ? trans
                        : secondaryColor);
              },
              separatorBuilder: (_, index) => sixteenVerticalSpace,
              itemCount: AppConstant.typeList.length),
          PrimaryButton(
            onTap: () async {
              await taskState.getTodayTaskList();
              Navigator.pop(context);
            },
            buttonTitle: 'Apply',
            buttonColor: taskState.selectedFilterType == '' ? primaryLight : primaryColor,
          ),
          primaryVerticalSpace
        ],
      ),
    );
  }
}
