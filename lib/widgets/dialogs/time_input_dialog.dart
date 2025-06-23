import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/time_tracking_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';

class TimeInputDialog extends StatefulWidget {
  final bool isGoal;
  final String itemId; // This will be either goal_id or task_id

  const TimeInputDialog({
    Key? key,
    required this.isGoal,
    required this.itemId,
  }) : super(key: key);

  @override
  State<TimeInputDialog> createState() => _TimeInputDialogState();
}

class _TimeInputDialogState extends State<TimeInputDialog> {
  int selectedHours = 0;
  int selectedMinutes = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          color: white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: iconColor),
                  ),
                  Text(
                    'Time input',
                    style: tTextStyle500.copyWith(fontSize: 20, color: black),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: iconColor),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hours',
                    style: tTextStyle500.copyWith(fontSize: 16, color: black),
                  ),
                  sixteenVerticalSpace,
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7, // 0-6 hours
                      separatorBuilder: (_, __) => eightHorizontalSpace,
                      itemBuilder: (context, index) {
                        return _timeButton(
                          value: index,
                          isSelected: selectedHours == index,
                          onTap: () => setState(() => selectedHours = index),
                        );
                      },
                    ),
                  ),
                  twentyFourVerticalSpace,
                  Text(
                    'Minutes',
                    style: tTextStyle500.copyWith(fontSize: 16, color: black),
                  ),
                  sixteenVerticalSpace,
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4, // 0, 15, 30, 45 minutes
                      separatorBuilder: (_, __) => eightHorizontalSpace,
                      itemBuilder: (context, index) {
                        final minutes = index * 15;
                        return _timeButton(
                          value: minutes,
                          isSelected: selectedMinutes == minutes,
                          onTap: () => setState(() => selectedMinutes = minutes),
                        );
                      },
                    ),
                  ),
                  twentyFourVerticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _submitTime(context),
                      child: Text(
                        'Submit',
                        style: tTextStyle500.copyWith(
                          fontSize: 16,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeButton({
    required int value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? primaryColor : borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          value.toString(),
          style: tTextStyle500.copyWith(
            fontSize: 16,
            color: isSelected ? white : black,
          ),
        ),
      ),
    );
  }

  void _submitTime(BuildContext context) async {
    final totalMinutes = (selectedHours * 60) + selectedMinutes;
    if (totalMinutes == 0) {
      // Show error or warning
      return;
    }

    final timeTrackingProvider = Provider.of<TimeTrackingProvider>(
      context, 
      listen: false
    );

    await timeTrackingProvider.addTimeEntry(
      timeSpent: totalMinutes,
      goalId: widget.isGoal ? widget.itemId : null,
      taskId: widget.isGoal ? null : widget.itemId,
    );

    Navigator.of(context).pop(); // Close time input dialog
    Navigator.of(context).pop(); // Close add time dialog
  }
} 