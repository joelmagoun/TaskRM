import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:TaskRM/models/goal.dart';
import 'package:TaskRM/models/task.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoalTile extends StatefulWidget {
  final String goalId;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final String title;
  final bool isTimeTracking;
  final String time;
  final Color cardColor;
  final Color titleColor;
  final Color timeDateColor;
  final bool isSelected;
  final String createdAt;
  final Goal goal;

  const GoalTile(
      {Key? key,
      required this.goalId,
      required this.onLongPress,
      required this.onTap,
      required this.title,
      required this.isTimeTracking,
      required this.time,
      required this.cardColor,
      required this.titleColor,
      required this.timeDateColor,
      required this.isSelected,
      required this.createdAt,
      required this.goal})
      : super(key: key);

  @override
  State<GoalTile> createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  String getTimeAgo(String dateTime) {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    dateTime = timeago.format(DateTime.parse(dateTime), locale: 'en');
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
      onTap: widget.onTap,
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
                                      AppLocalizations.of(context)!
                                          .timetracking,
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
                                AppLocalizations.of(context)!.timetracking,
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
