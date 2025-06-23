import 'package:flutter/material.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/time_tracking_provider.dart';

class TimeTrackerDialog extends StatefulWidget {
  final bool isGoal;
  final String itemId;

  const TimeTrackerDialog({
    Key? key,
    required this.isGoal,
    required this.itemId,
  }) : super(key: key);

  @override
  State<TimeTrackerDialog> createState() => _TimeTrackerDialogState();
}

class _TimeTrackerDialogState extends State<TimeTrackerDialog> {
  bool isTracking = false;
  Duration elapsed = Duration.zero;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    _checkForActiveTimer();
  }

  Future<void> _checkForActiveTimer() async {
    final provider = Provider.of<TimeTrackingProvider>(context, listen: false);
    final activeTimer = await provider.getActiveTimer(
      itemId: widget.itemId,
      isGoal: widget.isGoal,
    );
    
    if (activeTimer != null) {
      setState(() {
        isTracking = true;
        startTime = DateTime.parse(activeTimer['start_time']);
        // Start updating the elapsed time
        _startTimer();
      });
    }
  }

  void _startTimer() async {
    final provider = Provider.of<TimeTrackingProvider>(context, listen: false);
    final now = DateTime.now();
    
    try {
      await provider.startTimeTracking(
        itemId: widget.itemId,
        isGoal: widget.isGoal,
        startTime: now,
      );

      setState(() {
        isTracking = true;
        startTime = now;
      });
      
      // Start periodic timer to update display
      Stream.periodic(const Duration(seconds: 1)).listen((event) {
        if (mounted && isTracking) {
          setState(() {
            elapsed = DateTime.now().difference(startTime);
          });
        }
      });
    } catch (e) {
      print('Error starting timer: $e');
      // Optionally show error to user
    }
  }

  Future<void> _stopTimer() async {
    setState(() {
      isTracking = false;
    });

    final provider = Provider.of<TimeTrackingProvider>(context, listen: false);
    await provider.stopTimeTracking(
      itemId: widget.itemId,
      isGoal: widget.isGoal,
      startTime: startTime,
      stopTime: DateTime.now(),
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String hours = elapsed.inHours.toString().padLeft(2, '0');
    String minutes = (elapsed.inMinutes % 60).toString().padLeft(2, '0');

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
                    'Time Tracker',
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
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hours,
                    style: tTextStyle500.copyWith(fontSize: 48, color: black),
                  ),
                  Text(
                    'Hr : ',
                    style: tTextStyle500.copyWith(fontSize: 48, color: Colors.grey),
                  ),
                  Text(
                    minutes,
                    style: tTextStyle500.copyWith(fontSize: 48, color: black),
                  ),
                  Text(
                    'M',
                    style: tTextStyle500.copyWith(fontSize: 48, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: InkWell(
                onTap: isTracking ? _stopTimer : _startTimer,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isTracking ? Colors.red : Colors.teal,
                  ),
                  child: Icon(
                    isTracking ? Icons.stop : Icons.play_arrow,
                    color: white,
                    size: 32,
                  ),
                ),
              ),
            ),
            Text(
              isTracking ? 'Stop Tracking' : 'Start Tracking',
              style: tTextStyle500.copyWith(fontSize: 16, color: black),
            ),
            thirtyTwoSpacerVertical,
          ],
        ),
      ),
    );
  }
} 