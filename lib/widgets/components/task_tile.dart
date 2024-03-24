import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_rm/utils/assets_path.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../routes/routes.dart';

class TaskTile extends StatefulWidget {
  final VoidCallback onLongPress;
  final String title;
  final bool isTimeTracking;
  final String time;
  final Color cardColor;
  final Color titleColor;
  final Color timeDateColor;
  final bool isSelected;
  final String createdAt;

  const TaskTile({
    Key? key,
    required this.onLongPress,
    required this.title,
    required this.isTimeTracking,
    required this.time,
    required this.cardColor,
    required this.titleColor,
    required this.timeDateColor,
    required this.isSelected,
    required this.createdAt
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {

  String getTimeAgo(String dateTime) {
    timeago.setLocaleMessages('en', timeago.EnMessages());
      dateTime = timeago.format(DateTime.parse(dateTime),
          locale: 'en');
    return dateTime;
  }

  @override
  void initState() {
   getTimeAgo(widget.createdAt);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      onTap: (){
        Navigator.pushNamed(context, Routes.taskDetails);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: widget.cardColor
            //color: const Color(0xFFF0F1F8),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.isSelected
              ? Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: tTextStyleRegular.copyWith(
                                fontSize: 16, color: widget.titleColor),
                          ),
                          eightVerticalSpace,
                          widget.isTimeTracking
                              ? Row(
                                  children: [
                                    SvgPicture.asset(timerIcon),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Time tracking',
                                      style: tTextStyleRegular.copyWith(
                                          fontSize: 14, color: iconColor),
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
                                color: widget.timeDateColor,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                widget.time,
                                style: tTextStyleRegular.copyWith(
                                    fontSize: 14, color: widget.timeDateColor),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 20,
                                color: widget.timeDateColor,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                getTimeAgo(widget.createdAt),
                                style: tTextStyleRegular.copyWith(
                                    fontSize: 14, color: widget.timeDateColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(checkBox),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: tTextStyleRegular.copyWith(
                          fontSize: 16, color: widget.titleColor),
                    ),
                    eightVerticalSpace,
                    widget.isTimeTracking
                        ? Row(
                            children: [
                              SvgPicture.asset(timerIcon),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Time tracking',
                                style: tTextStyleRegular.copyWith(
                                    fontSize: 14, color: iconColor),
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
                          color: widget.timeDateColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.time,
                          style: tTextStyleRegular.copyWith(
                              fontSize: 14, color: widget.timeDateColor),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: widget.timeDateColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                            getTimeAgo(widget.createdAt),
                          style: tTextStyleRegular.copyWith(
                              fontSize: 14, color: widget.timeDateColor),
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
