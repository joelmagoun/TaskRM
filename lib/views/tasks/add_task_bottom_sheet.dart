import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:TaskRM/views/tasks/newTask/add_new_task_bottomsheet.dart';
import '../../../../utils/color.dart';
import '../../../../utils/spacer.dart';
import '../../routes/routes.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            eightVerticalSpace,
            _header(),
            eightVerticalSpace,
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _optionTile(() {
                    Navigator.pushNamed(context, Routes.taskQueue);
                  }, queueIcon, 'Select from queue'),
                  _optionTile(() {
                    CustomDialog.bottomSheet(
                        context, const AddNewTaskBottomSheet());
                  }, newTaskIcon, 'New task'),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
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
          'Add task',
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

  Widget _optionTile(VoidCallback onTap, String icon, String title) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(icon),
          Text(
            title,
            style: tTextStyleRegular.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}
