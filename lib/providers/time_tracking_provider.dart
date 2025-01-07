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

  Future<Map<String, dynamic>?> getActiveTimer({
    required String itemId,
    required bool isGoal,
  }) async {
    try {
      final uid = await AppStorage.getUserId();
      final field = isGoal ? 'goal_id' : 'task_id';
      
      final results = await db.getAll(
        '''
        SELECT * FROM time_tracking 
        WHERE user_id = ? 
        AND $field = ? 
        AND start_time IS NOT NULL 
        AND stop_time IS NULL
        ORDER BY created_at DESC 
        LIMIT 1
        ''',
        [uid, itemId],
      );

      if (results.isNotEmpty) {
        return results.first;
      }
      return null;
    } catch (e) {
      print('Error getting active timer: $e');
      return null;
    }
  }

  Future<void> startTimeTracking({
    required String itemId,
    required bool isGoal,
    required DateTime startTime,
  }) async {
    try {
      final uid = await AppStorage.getUserId();
      final now = startTime.toIso8601String();
      var docIdForPower = Random().nextInt(10000000);

      await db.execute(
        '''
        INSERT INTO time_tracking(
          id, created_at, updated_at, user_id, 
          goal_id, task_id, start_time
        ) VALUES(?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          docIdForPower.toString(),
          now,
          now,
          uid,
          isGoal ? itemId : null,
          isGoal ? null : itemId,
          now,
        ],
      );
      
      notifyListeners();
    } catch (e) {
      print('Error starting time tracking: $e');
      rethrow;
    }
  }

  Future<void> stopTimeTracking({
    required String itemId,
    required bool isGoal,
    required DateTime startTime,
    required DateTime stopTime,
  }) async {
    try {
      final uid = await AppStorage.getUserId();
      final timeSpent = stopTime.difference(startTime).inMinutes;
      
      // Update the existing entry
      await db.execute(
        '''
        UPDATE time_tracking 
        SET stop_time = ?, 
            time_spent = ?,
            updated_at = ?
        WHERE user_id = ? 
        AND ${isGoal ? 'goal_id' : 'task_id'} = ?
        AND start_time = ?
        AND stop_time IS NULL
        ''',
        [
          stopTime.toIso8601String(),
          timeSpent,
          stopTime.toIso8601String(),
          uid,
          itemId,
          startTime.toIso8601String(),
        ],
      );
      
      notifyListeners();
    } catch (e) {
      print('Error stopping time tracking: $e');
      rethrow;
    }
  }
} 