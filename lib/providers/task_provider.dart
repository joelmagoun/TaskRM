import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/custom_snack.dart';
import '../models/task.dart';
import '../powersync.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    _init();
  }

  _init() {
    getTodayTaskList();
    getAllTaskList();
  }

  final SupabaseConnector _connector = SupabaseConnector(db);

  /// Jira ///
  late bool _isJiraIssueAdded = false;

  bool get isJiraIssueAdded => _isJiraIssueAdded;

  late String _jiraId = '';

  String get jiraId => _jiraId;

  setJiraId(String jiraID, bool value) {
    _jiraId = jiraID;
    notifyListeners();
    _isJiraIssueAdded = value;
    notifyListeners();
  }

  /// add new task ///

  late bool _isTaskAdding = false;

  bool get isTaskAdding => _isTaskAdding;
  set isTaskAdding(bool value) {
    _isTaskAdding = value;
    notifyListeners();
  }

  late String _selectedGoal = 'Select';

  String get selectedGoal => _selectedGoal;

  late String _selectedGoalId = '';

  String get selectedGoalId => _selectedGoalId;

  getSelectedGoal(String goal, String goalId, BuildContext context) {
    _selectedGoal = goal;
    _selectedGoalId = goalId;
    notifyListeners();
    //Navigator.pop(context);
  }

  /// for filter  ///
  late String _selectedFilterType = '';

  String get selectedFilterType => _selectedFilterType;

  void getFilterType(String workType) {
    _selectedFilterType = workType;
    notifyListeners();
  }

  /// get today task list ///

  late bool _isTaskLoading = false;

  bool get isTaskLoading => _isTaskLoading;

  late Stream<List<Task>> taskStream;

  late List<Task> _todayTaskList = [];

  List<Task> get todayTaskList => _todayTaskList;

  /// Get all list IDs

  Future<void> getTodayTaskList() async {
    try {
      _isTaskLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();
      final today = DateTime.now().toIso8601String().split('T')[0];

      final query = """
        SELECT * FROM tasks 
        WHERE user_id = '$uid' 
        AND date(expected_completion) = '$today'
        ${_showCompletedTasks ? '' : 'AND is_completed = 0'}
        ORDER BY created_at DESC
      """;

      print('Today Tasks Query: $query');
      print('Today\'s date for comparison: $today');

      db.watch(query).map((results) {
        print('Today Tasks Results count: ${results.length}');
        if (results.isNotEmpty) {
          results.forEach((row) {
            print('Task date: ${row['expected_completion']}');
          });
          _todayTaskList.clear();
          notifyListeners();
          return results.map((e) {
            if (_selectedFilterType == '') {
              _todayTaskList.add(Task(
                id: e['id'] ?? 0,
                createdAt: e['created_at'] ?? '',
                updatedAt: e['updated_at'] ?? '',
                timeframe: e['timeframe'] ?? '',
                jiraId: e['jira_id'] ?? '',
                title: e['title'] ?? '',
                type: e['type'] ?? '',
                isMarkedForToday: e['is_marked_for_today'] ?? false,
                goalId: e['goal_id'] ?? '',
                priority: e['priority'] ?? '',
                description: e['description'] ?? '',
                userId: e['user_id'] ?? '',
                goal: e['goal'] ?? '',
                expectedCompletion: e['expected_completion'] ?? '',
                isCompleted: e['is_completed'] ?? false,
                totalMinutesSpent: e['total_minutes_spent'] ?? 0,
              ));
              notifyListeners();
            } else if (_selectedFilterType != '') {
              if (e['type'] == _selectedFilterType) {
                _todayTaskList.add(Task(
                  id: e['id'] ?? 0,
                  createdAt: e['created_at'] ?? '',
                  updatedAt: e['updated_at'] ?? '',
                  timeframe: e['timeframe'] ?? '',
                  jiraId: e['jira_id'] ?? '',
                  title: e['title'] ?? '',
                  type: e['type'] ?? '',
                  isMarkedForToday: e['is_marked_for_today'] ?? false,
                  goalId: e['goal_id'] ?? '',
                  priority: e['priority'] ?? '',
                  description: e['description'] ?? '',
                  userId: e['user_id'] ?? '',
                  goal: e['goal'] ?? '',
                  expectedCompletion: e['expected_completion'] ?? '',
                  isCompleted: e['is_completed'] ?? false,
                  totalMinutesSpent: e['total_minutes_spent'] ?? 0,
                ));
                notifyListeners();
              }
            }

            notifyListeners();
          }).toList();
        }
      }).toList();
    } catch (e) {
      print('Error in getTodayTaskList: ${e.toString()}');
    } finally {
      _isTaskLoading = false;
      notifyListeners();
    }
  }

  /// all task list ///

  late bool _isAllTaskLoading = false;

  bool get isAllTaskLoading => _isAllTaskLoading;

  late List<Task> _allTaskList = [];

  List<Task> get allTaskList => _allTaskList;

  late String _selectedQueueTimeFrame = '';

  String get selectedQueueTimeFrame => _selectedQueueTimeFrame;
  late String _selectedQueueType = '';

  String get selectedQueueType => _selectedQueueType;

  void getQueueFilterTimeType(String workType, String timeFrame) {
    _selectedQueueType = workType;
    notifyListeners();
    _selectedQueueTimeFrame = timeFrame;
    notifyListeners();
  }

  Future<void> getAllTaskList() async {
    try {
      _isAllTaskLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();
      final today = DateTime.now().toIso8601String().split('T')[0];

      final query = """
        SELECT * FROM tasks 
        WHERE user_id = '$uid' 
        AND (date(expected_completion) > '$today' OR date(expected_completion) < '$today')
        ${_showCompletedTasks ? '' : 'AND is_completed = 0'}
        ORDER BY created_at DESC
      """;

      print('Queue Tasks Query: $query');
      print('Today\'s date for comparison: $today');

      db.watch(query).map((results) {
        print('Queue Tasks Results count: ${results.length}');
        if (results.isNotEmpty) {
          results.forEach((row) {
            print('Task date: ${row['expected_completion']}');
          });
          _allTaskList.clear();
          notifyListeners();
          return results.map((e) {
            // String timeFrameResult =
            // getTimeFrameFromExpectedDate(e['expected_completion']);

            if (_selectedQueueTimeFrame == '' || _selectedQueueType == '') {
              _allTaskList.add(Task(
                id: e['id'] ?? 0,
                createdAt: e['created_at'] ?? '',
                updatedAt: e['updated_at'] ?? '',
                timeframe: e['timeframe'] ?? '',
                jiraId: e['jira_id'] ?? '',
                title: e['title'] ?? '',
                type: e['type'] ?? '',
                isMarkedForToday: e['is_marked_for_today'] ?? false,
                goalId: e['goal_id'] ?? '',
                priority: e['priority'] ?? '',
                description: e['description'] ?? '',
                userId: e['user_id'] ?? '',
                goal: e['goal'] ?? '',
                expectedCompletion: e['expected_completion'] ?? '',
                isCompleted: e['is_completed'] ?? false,
                totalMinutesSpent: e['total_minutes_spent'] ?? 0,
              ));
              notifyListeners();
            } else if (_selectedQueueTimeFrame != '' ||
                _selectedQueueType != '') {
              if (e['type'] == _selectedQueueType &&
                  e['timeframe'] == _selectedQueueTimeFrame) {
                _allTaskList.add(Task(
                  id: e['id'] ?? 0,
                  createdAt: e['created_at'] ?? '',
                  updatedAt: e['updated_at'] ?? '',
                  timeframe: e['timeframe'] ?? '',
                  jiraId: e['jira_id'] ?? '',
                  title: e['title'] ?? '',
                  type: e['type'] ?? '',
                  isMarkedForToday: e['is_marked_for_today'] ?? false,
                  goalId: e['goal_id'] ?? '',
                  priority: e['priority'] ?? '',
                  description: e['description'] ?? '',
                  userId: e['user_id'] ?? '',
                  goal: e['goal'] ?? '',
                  expectedCompletion: e['expected_completion'] ?? '',
                  isCompleted: e['is_completed'] ?? false,
                  totalMinutesSpent: e['total_minutes_spent'] ?? 0,
                ));
                notifyListeners();
              }
            }

            notifyListeners();
          }).toList();
        }
      }).toList();
    } catch (e) {
      print('Error in getAllTaskList: ${e.toString()}');
    } finally {
      _isAllTaskLoading = false;
      notifyListeners();
    }
  }

  /// add task state ///

  final SupabaseConnector supabaseConnector = SupabaseConnector(db);

  Future<void> addNewTask(
    String title,
    String type,
    String goalId,
    String priority,
    String timeFrame,
    String description,
    String goal,
    BuildContext context,
  ) async {
    try {
      _isTaskAdding = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      var docIdForPower = Random().nextInt(10000000);

      var result = await db.writeTransaction((tx) async {
        await tx.execute(
            'INSERT INTO tasks( id, created_at, updated_at, timeframe, jira_id, title, type, is_marked_for_today, goal_id, priority, description, user_id, goal, expected_completion, is_completed, total_minutes_spent) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [
              docIdForPower.toString(),
              DateTime.now().toIso8601String(),
              DateTime.now().toIso8601String(),
              timeFrame,
              '',
              title,
              type,
              timeFrame == 'Today' ? 1 : 0,
              goalId,
              priority,
              description,
              uid,
              goal,
              //timeFrame,
              getExpectedDateFromTimeframe(timeFrame).toIso8601String(),
              0,
              0,
            ]);
      });

      Navigator.pop(context);
      // await getTodayTaskList();
      // await getAllTaskList();
      //
      CustomDialog.autoDialog(
          context, Icons.check, 'Task is added successfully!');
    } catch (e) {
      print('catch error ${e.toString()}');
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isTaskAdding = false;
      notifyListeners();
    }
  }

  /// move to today task list ///

  late bool _isMoving = false;

  bool get isMoving => _isMoving;
  set isMoving(bool value) {
    _isMoving = value;
    notifyListeners();
  }

  Future<void> moveToTodayTaskList(
    int taskId,
    String createdAt,
    BuildContext context,
  ) async {
    try {
      isMoving = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();
      final now = DateTime.now().toIso8601String();

      // Update the task's status directly in PowerSync
      await db.execute(
        '''
        UPDATE tasks 
        SET 
          expected_completion = ?,
          updated_at = ?
        WHERE id = ? AND user_id = ?
        ''',
        [now, now, taskId.toString(), uid],
      );

      // Refresh both task lists
      await getAllTaskList();
      await getTodayTaskList();

      isMoving = false;
      notifyListeners();

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      isMoving = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to move task to today\'s list'),
          ),
        );
      }
      print('Error moving task to today: $e');
    }
  }

  /// for finding timeframe and expectedDate ///

  String getTimeFrameFromExpectedDate(String expectedDate) {
    // //2024-04-08 03:36:07.983147

    final now = DateTime.now();
    DateTime parsedExpectedDate = DateTime.parse(expectedDate);
    Duration remainDays = parsedExpectedDate.difference(now);

    if (remainDays.inDays == 1 || remainDays.inDays == 0) {
      return 'Today';
    } else if (remainDays.inDays > 1 && remainDays.inDays <= 3) {
      return '3 days';
    } else if (remainDays.inDays > 3 && remainDays.inDays <= 7) {
      return 'Week';
    } else if (remainDays.inDays > 7 && remainDays.inDays <= 14) {
      return 'Fortnight';
    } else if (remainDays.inDays > 14 && remainDays.inDays <= 30) {
      return 'Month';
    } else if (remainDays.inDays > 30 && remainDays.inDays <= 90) {
      return '90 days';
    } else if (remainDays.inDays > 90 && remainDays.inDays <= 365) {
      return 'Year';
    } else {
      return 'Date over';
    }
  }

  DateTime getExpectedDateFromTimeframe(String timeFrame) {
    final now = DateTime.now();

    switch (timeFrame) {
      case "Today":
        return now.add(const Duration(days: 0));
      case "3 days":
        return now.add(const Duration(days: 3));
      case "Week":
        return now.add(const Duration(days: 7));
      case "Fortnight":
        return now.add(const Duration(days: 14));
      case "Month":
        return now.add(const Duration(days: 30));
      case "90 days":
        return now.add(const Duration(days: 90));
      case "Year":
        return now.add(const Duration(days: 365));
      default:
        return DateTime.now();
    }
  }

  late bool _isCompletingTask = false;
  bool get isCompletingTask => _isCompletingTask;

  Future<void> toggleTaskComplete(
      String taskId, bool currentStatus, BuildContext context) async {
    try {
      _isCompletingTask = true;
      notifyListeners();

      await db.writeTransaction((tx) async {
        await tx.execute(
            'UPDATE tasks SET is_completed = ?, updated_at = ? WHERE id = ?',
            [currentStatus ? 0 : 1, DateTime.now().toIso8601String(), taskId]);
      });

      CustomSnack.successSnack(
          'Task ${!currentStatus ? "completed" : "uncompleted"} successfully!',
          context);
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isCompletingTask = false;
      notifyListeners();
    }
  }

  bool _showCompletedTasks = false;
  bool get showCompletedTasks => _showCompletedTasks;

  void toggleShowCompletedTasks() {
    _showCompletedTasks = !_showCompletedTasks;
    notifyListeners();
    getTodayTaskList(); // Refresh lists with new filter
    getAllTaskList();
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await db.execute(
        'DELETE FROM tasks WHERE id = ?',
        [taskId],
      );
      await getAllTaskList(); // Refresh the tasks list
      notifyListeners();
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }

  Future<void> updateTask({
    required String taskId,
    required String title,
    required String type,
    required String priority,
    required String timeframe,
    required String description,
    required BuildContext context,
  }) async {
    try {
      isTaskAdding = true;
      notifyListeners();

      final now = DateTime.now().toIso8601String();

      await db.execute(
        '''
        UPDATE tasks 
        SET 
          title = ?,
          type = ?,
          priority = ?,
          timeframe = ?,
          description = ?,
          updated_at = ?
        WHERE id = ?
        ''',
        [title, type, priority, timeframe, description, now, taskId],
      );

      await getAllTaskList(); // Refresh the tasks list
      
      if (context.mounted) {
        Navigator.pop(context);
        CustomDialog.autoDialog(context, Icons.check, 'Task updated successfully!');
      }
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isTaskAdding = false;
      notifyListeners();
    }
  }
}
