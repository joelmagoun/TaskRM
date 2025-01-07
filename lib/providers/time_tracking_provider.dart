import 'dart:math';
import 'package:flutter/material.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:powersync/powersync.dart';

class TimeTrackingProvider extends ChangeNotifier {
  final PowerSyncDatabase db;

  TimeTrackingProvider({required this.db});

  Future<void> addTimeEntry({
    required int timeSpent,
    String? goalId,
    String? taskId,
  }) async {
    try {
      final uid = await AppStorage.getUserId();
      final now = DateTime.now().toIso8601String();
      var docIdForPower = Random().nextInt(10000000);

      await db.execute(
        '''
        INSERT INTO time_tracking(
          id,
          created_at,
          updated_at,
          user_id, 
          goal_id, 
          task_id, 
          time_spent
        ) VALUES(?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          docIdForPower.toString(),
          now,
          now,
          uid, 
          goalId, 
          taskId, 
          timeSpent
        ],
      );

    } catch (e) {
      print('Error adding time entry: $e');
      rethrow;
    }
  }
} 