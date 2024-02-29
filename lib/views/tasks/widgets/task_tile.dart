import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';

class TaskTile extends StatelessWidget {
  final VoidCallback onLongPress;
  final String title;
  final bool isTimeTracking;
  final String time;
  final String date;
  final Color cardColor;
  final Color titleColor;
  final Color timeDateColor;
  final bool isSelected;

  const TaskTile({
    Key? key,
    required this.onLongPress,
    required this.title,
    required this.isTimeTracking,
    required this.time,
    required this.date,
    required this.cardColor,
    required this.titleColor,
    required this.timeDateColor,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: cardColor
            //color: const Color(0xFFF0F1F8),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isSelected ? Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                    tTextStyleRegular.copyWith(fontSize: 16, color: titleColor),
                  ),
                  eightVerticalSpace,
                  isTimeTracking
                      ? Row(
                    children: [
                      SvgPicture.asset(timerIcon),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Time tracking',
                        style: tTextStyleRegular.copyWith(
                            fontSize: 14, color: textGreyColor),
                      )
                    ],
                  )
                      : const SizedBox.shrink(),
                  eightVerticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 20,
                        color: timeDateColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        time,
                        style: tTextStyleRegular.copyWith(
                            fontSize: 14, color: timeDateColor),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                        color: timeDateColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '$date days ago',
                        style: tTextStyleRegular.copyWith(
                            fontSize: 14, color: timeDateColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            SvgPicture.asset(checkBox),
          ],) :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                tTextStyleRegular.copyWith(fontSize: 16, color: titleColor),
              ),
              eightVerticalSpace,
              isTimeTracking
                  ? Row(
                children: [
                  SvgPicture.asset(timerIcon),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Time tracking',
                    style: tTextStyleRegular.copyWith(
                        fontSize: 14, color: textGreyColor),
                  )
                ],
              )
                  : const SizedBox.shrink(),
              eightVerticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 20,
                    color: timeDateColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    time,
                    style: tTextStyleRegular.copyWith(
                        fontSize: 14, color: timeDateColor),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: timeDateColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '$date days ago',
                    style: tTextStyleRegular.copyWith(
                        fontSize: 14, color: timeDateColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
