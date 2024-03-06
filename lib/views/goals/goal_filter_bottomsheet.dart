import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/taskQueue/widgets/filter_option_tile.dart';
import 'package:task_rm/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../providers/goals_provider.dart';

class GoalFilterBottomSheet extends StatefulWidget {
  const GoalFilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<GoalFilterBottomSheet> createState() => _GoalFilterBottomSheetState();
}

class _GoalFilterBottomSheetState extends State<GoalFilterBottomSheet> {
  late String selectedType = '';

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

    final goalState = Provider.of<GoalProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              goalState.getFilterType(selectedType);
              await goalState.getGoalList();
              Navigator.pop(context);
            },
            buttonTitle: 'Apply',
            buttonColor: selectedType == ''
                ? primaryLight
                : primaryColor,
          ),
          primaryVerticalSpace
        ],
      ),
    );
  }

}
