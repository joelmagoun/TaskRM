import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/auth_provider.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:task_rm/views/tasks/add_task_bottom_sheet.dart';
import '../../utils/assets_path.dart';

class TodayTaskScreen extends StatelessWidget {
  const TodayTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, _authState, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: Border(
              bottom: BorderSide(
                  color: borderColor,
                  width: 1
              )
          ),
          title: Text(
            'Today’s tasks',
            style: tTextStyle500.copyWith(fontSize: 20, color: black),
          ),
        ),
        body: _emptyListWidget(context),
      );
    });
  }

  Widget _emptyListWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          taskIcon,
          height: 120,
          width: 120,
          color: assColor,
        ),
        sixteenVerticalSpace,
        Text(
          'No tasks for today',
          style: tTextStyle500.copyWith(fontSize: 20, color: black),
        ),
        Text(
          'Add tasks by creating new ones or selecting from the queue.',
          textAlign: TextAlign.center,
          style: tTextStyleRegular.copyWith(fontSize: 16),
        ),
        sixteenVerticalSpace,
        IconButton(onPressed: (){
          CustomDialog.bottomSheet(context, const AddTaskBottomSheet());
        }, icon: const Icon(Icons.add_circle_rounded,), color: primaryColor, iconSize: 64,)
      ],
    );
  }

}
