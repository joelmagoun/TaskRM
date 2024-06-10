import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  String _formatHours(int milliseconds) {
    final int hours = milliseconds ~/ (1000 * 60 * 60);
    return '$hours';
  }

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch Timer'),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data!;
             // final displayTime = StopWatchTimer.getDisplayTime(value);
              final displayTime = _formatHours(value);
              return Text(
                displayTime,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                 // _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                  _stopWatchTimer.onStartTimer();
                },
                child: Text('Start'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  //_stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                  _stopWatchTimer.onStopTimer();
                },
                child: Text('Stop'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  //_stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}