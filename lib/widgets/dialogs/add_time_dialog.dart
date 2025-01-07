import 'package:flutter/material.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';

class AddTimeDialog extends StatelessWidget {
  final bool isGoal; // To differentiate between goal and task

  const AddTimeDialog({
    Key? key,
    required this.isGoal,
  }) : super(key: key);

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
                  Text(
                    'Add Time',
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
            _optionTile(
              context: context,
              icon: Icons.timer,
              title: 'Time tracker',
              subtitle: 'Use timer to begin your task and "Stop" when finished or pausing progress',
              onTap: () {
                // TODO: Implement timer functionality
                Navigator.pop(context);
              },
            ),
            const Divider(),
            _optionTile(
              context: context,
              icon: Icons.edit_calendar,
              title: 'Time input',
              subtitle: 'Enter the approximate amount of time you have worked on this ${isGoal ? 'goal' : 'task'}',
              onTap: () {
                // TODO: Implement manual time input
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _optionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 24),
            sixteenHorizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tTextStyle500.copyWith(
                      fontSize: 16,
                      color: textPrimaryColor,
                    ),
                  ),
                  fourVerticalSpace,
                  Text(
                    subtitle,
                    style: tTextStyleRegular.copyWith(
                      fontSize: 14,
                      color: textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
} 