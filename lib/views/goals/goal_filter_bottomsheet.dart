import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/taskQueue/widgets/filter_option_tile.dart';
import 'package:TaskRM/widgets/components/buttons/primary_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../../providers/goals_provider.dart';
import '../../utils/constant/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          child: Consumer<GoalProvider>(builder: (_, goalState, child) {
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

    final goalState = Provider.of<GoalProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      goalState.getFilterType(type);
                    },
                    title: AppConstant.convertType(type),
                    checkBoxColor: goalState.selectedFilterType == type
                        ? primaryColor
                        : white,
                    boxBorderColor: goalState.selectedFilterType == type
                        ? trans
                        : secondaryColor);
              },
              separatorBuilder: (_, index) => sixteenVerticalSpace,
              itemCount: AppConstant.typeList.length),
          PrimaryButton(
            onTap: () async {
              await goalState.getGoalList();
              Navigator.pop(context);
            },
            buttonTitle: AppLocalizations.of(context)!.apply,
            buttonColor: goalState.selectedFilterType == ''
                ? primaryLight
                : primaryColor,
          ),
          primaryVerticalSpace
        ],
      ),
    );
  }

}
