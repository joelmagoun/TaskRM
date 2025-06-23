import 'dart:math';

import 'package:flutter/material.dart';
import 'package:TaskRM/models/goal.dart';
import 'package:TaskRM/models/task.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:TaskRM/utils/custom_snack.dart';
import '../powersync.dart';
import '../utils/config/constants.dart';
import '../utils/custom_dialog.dart';

class GoalProvider extends ChangeNotifier {
  GoalProvider() {
    _init();
  }

  // Client client = Client();
  // late Databases db;

  _init() {
    // client
    //     .setEndpoint(AppWriteConstant.endPoint)
    //     .setProject(AppWriteConstant.projectId);
    // db = Databases(client);
    getGoalList();
  }

  /// get goal list ///

  late bool _isGoalLoading = false;

  bool get isGoalLoading => _isGoalLoading;

  late List<Goal> _allGoalList = [];

  List<Goal> get allGoalList => _allGoalList;

  late String _selectedFilterType = '';

  String get selectedFilterType => _selectedFilterType;

  void getFilterType(String workType) {
    _selectedFilterType = workType;
    notifyListeners();
  }

  Future<void> getGoalList() async {
    try {
      _isGoalLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final query = """
        SELECT * FROM goals 
        WHERE user_id = '$uid' 
        ${_selectedFilterType.isNotEmpty ? "AND type = '$_selectedFilterType'" : ''}
        ${_showCompletedGoals ? '' : 'AND (is_completed = 0 OR is_completed IS NULL)'}
        AND (parent_goal = '0' OR parent_goal IS NULL OR parent_goal = '')
        ORDER BY created_at DESC
      """;

      print('Goals Query: $query'); // For debugging
      
      final results = await db.getAll(query);
      
      _allGoalList.clear();
      results.forEach((e) {
        _allGoalList.add(Goal(
          id: e['id'] ?? '',
          title: e['title'] ?? '',
          type: e['type'] ?? '',
          description: e['description'] ?? '',
          isCompleted: e['is_completed'] ?? 0,
          userId: e['user_id'] ?? '',
          parentGoal: e['parent_goal'],
          createdAt: DateTime.parse(e['created_at'])
        ));
      });
      
      notifyListeners();

    } catch (e) {
      print('Error in getGoalList: ${e.toString()}');
    } finally {
      _isGoalLoading = false;
      notifyListeners();
    }
  }

  /// add goal state ///

  late bool _isGoalAdding = false;

  bool get isGoalAdding => _isGoalAdding;

  late String _selectedParentGoal = 'Select';

  String get selectedParentGoal => _selectedParentGoal;

  getSelectedParentGoal(String parentGoal, BuildContext context) {
    _selectedParentGoal = parentGoal;
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> addNewGoal(String title, String type, String description,
      BuildContext context) async {
    try {
      _isGoalAdding = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();
      var docIdForPower = Random().nextInt(10000000);

      await db.writeTransaction((tx) async {
        await tx.execute(
          'INSERT INTO goals(id, created_at, updated_at, title, user_id, description, type, parent_goal, is_completed) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            docIdForPower.toString(),
            DateTime.now().toIso8601String(),
            DateTime.now().toIso8601String(),
            title,
            uid,
            description,
            type,
            _selectedParentGoalId.isEmpty ? '0' : _selectedParentGoalId,
            0
          ]
        );
      });

      Navigator.pop(context);
      CustomDialog.autoDialog(context, Icons.check, 'Goal is added successfully!');
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isGoalAdding = false;
      notifyListeners();
    }
  }

  Future<void> toggleGoalComplete(String goalId, int currentStatus, BuildContext context) async {
    try {
      _isCompletingGoal = true;
      notifyListeners();

      await db.writeTransaction((tx) async {
        await tx.execute(
          'UPDATE goals SET is_completed = ?, updated_at = ? WHERE id = ?',
          [currentStatus == 1 ? 0 : 1, DateTime.now().toIso8601String(), goalId]
        );
      });

      CustomSnack.successSnack(
        'Goal ${currentStatus == 1 ? "uncompleted" : "completed"} successfully!',
        context
      );

    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isCompletingGoal = false;
      notifyListeners();
    }
  }

  bool _showCompletedGoals = false;
  bool get showCompletedGoals => _showCompletedGoals;

  void toggleShowCompletedGoals() {
    print('Toggling show completed goals. Before: $_showCompletedGoals'); // Debug
    _showCompletedGoals = !_showCompletedGoals;
    print('After toggle: $_showCompletedGoals'); // Debug
    notifyListeners();
    getGoalList();
  }

  bool _isCompletingGoal = false;
  bool get isCompletingGoal => _isCompletingGoal;

  List<Goal> _parentGoalsList = [];
  List<Goal> get parentGoalsList => _parentGoalsList;
  String _selectedParentGoalId = '';
  String get selectedParentGoalId => _selectedParentGoalId;
  String _selectedParentGoalTitle = 'Select';
  String get selectedParentGoalTitle => _selectedParentGoalTitle;

  Future<void> getParentGoalsList() async {
    try {
      final uid = await AppStorage.getUserId();
      
      final query = """
        SELECT * FROM goals 
        WHERE user_id = '$uid' 
        AND (parent_goal = '0' OR parent_goal IS NULL OR parent_goal = '')
        ${_selectedFilterType.isNotEmpty ? "AND type = '$_selectedFilterType'" : ''}
        AND (is_completed = 0 OR is_completed IS NULL)
        ORDER BY created_at DESC
      """;

      final results = await db.getAll(query);
      
      _parentGoalsList.clear();
      results.forEach((e) {
        _parentGoalsList.add(Goal(
          id: e['id'] ?? '',
          title: e['title'] ?? '',
          type: e['type'] ?? '',
          description: e['description'] ?? '',
          isCompleted: e['is_completed'] ?? 0,
          userId: e['user_id'] ?? '',
          parentGoal: e['parent_goal'],
          createdAt: DateTime.parse(e['created_at'])
        ));
      });
      
      notifyListeners();
    } catch (e) {
      print('Error fetching parent goals: ${e.toString()}');
    }
  }

  void setSelectedParentGoal(String goalId, String goalTitle) {
    _selectedParentGoalId = goalId;
    _selectedParentGoalTitle = goalTitle;
    notifyListeners();
  }

  void clearSelectedParentGoal() {
    _selectedParentGoalId = '';
    _selectedParentGoalTitle = 'Select';
    notifyListeners();
  }

  List<Goal> _subGoals = [];
  List<Goal> get subGoals => _subGoals;
  
  List<Task> _goalTasks = [];
  List<Task> get goalTasks => _goalTasks;
  
  bool _isLoadingSubGoals = false;
  bool get isLoadingSubGoals => _isLoadingSubGoals;
  
  bool _isLoadingGoalTasks = false;
  bool get isLoadingGoalTasks => _isLoadingGoalTasks;

  Future<void> getSubGoals(String parentGoalId) async {
    try {
      _isLoadingSubGoals = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();
      
      final query = """
        SELECT * FROM goals 
        WHERE user_id = '$uid' 
        AND parent_goal = '$parentGoalId'
        AND (is_completed = 0 OR is_completed IS NULL)
        ORDER BY created_at DESC
      """;

      final results = await db.getAll(query);
      
      _subGoals = results.map((e) => Goal(
        id: e['id'] ?? '',
        title: e['title'] ?? '',
        type: e['type'] ?? '',
        description: e['description'] ?? '',
        isCompleted: e['is_completed'] ?? 0,
        userId: e['user_id'] ?? '',
        parentGoal: e['parent_goal'],
        createdAt: DateTime.parse(e['created_at'])
      )).toList();
      
      notifyListeners();
    } catch (e) {
      print('Error fetching sub-goals: ${e.toString()}');
    } finally {
      _isLoadingSubGoals = false;
      notifyListeners();
    }
  }

  Future<void> getGoalTasks(String goalId) async {
    try {
      _isLoadingGoalTasks = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();
      
      final query = """
        SELECT * FROM tasks 
        WHERE user_id = '$uid' 
        AND goal_id = '$goalId'
        AND (is_completed = 0 OR is_completed IS NULL)
        ORDER BY created_at DESC
      """;

      final results = await db.getAll(query);
      
      _goalTasks = results.map((e) => Task.fromJson(e)).toList();
      
      notifyListeners();
    } catch (e) {
      print('Error fetching goal tasks: ${e.toString()}');
    } finally {
      _isLoadingGoalTasks = false;
      notifyListeners();
    }
  }

  Future<String> getParentGoalTitle(String? parentGoalId) async {
    if (parentGoalId == null || parentGoalId == '0' || parentGoalId.isEmpty) {
      return 'None';
    }

    try {
      final results = await db.getAll(
        'SELECT title FROM goals WHERE id = ?',
        [parentGoalId],
      );

      if (results.isNotEmpty) {
        return results.first['title'] ?? 'None';
      }
      return 'None';
    } catch (e) {
      print('Error fetching parent goal title: $e');
      return 'None';
    }
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      await db.execute(
        'DELETE FROM goals WHERE id = ?',
        [goalId],
      );
      await getGoalList(); // Refresh the goals list
      notifyListeners();
    } catch (e) {
      print('Error deleting goal: $e');
      rethrow;
    }
  }

  Future<void> updateGoal({
    required String goalId,
    required String title,
    required String type,
    required String description,
    required String parentGoalId,
    required BuildContext context,
  }) async {
    try {
      _isGoalAdding = true;
      notifyListeners();

      final now = DateTime.now().toIso8601String();

      await db.execute(
        '''
        UPDATE goals 
        SET 
          title = ?,
          type = ?,
          description = ?,
          parent_goal = ?,
          updated_at = ?
        WHERE id = ?
        ''',
        [title, type, description, parentGoalId, now, goalId],
      );

      await getGoalList(); // Refresh the goals list
      
      if (context.mounted) {
        Navigator.pop(context);
        CustomDialog.autoDialog(context, Icons.check, 'Goal updated successfully!');
      }
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isGoalAdding = false;
      notifyListeners();
    }
  }

  Future<String> getGoalTimeSpent(String goalId) async {
    try {
      // Get total minutes for this goal and all its children
      int totalMinutes = await _calculateTotalTimeForGoalAndChildren(goalId);
      
      // Convert to hours and minutes format
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;
      
      if (hours > 0) {
        return '$hours hr ${minutes > 0 ? '$minutes min' : ''}';
      } else {
        return '$minutes min';
      }
    } catch (e) {
      print('Error getting goal time spent: $e');
      return '0 min';
    }
  }

  Future<int> _calculateTotalTimeForGoalAndChildren(String goalId) async {
    int totalMinutes = 0;
    
    try {
      // 1. Get time spent directly on this goal
      final goalTimeResult = await db.execute(
        '''
        SELECT SUM(time_spent) as total_time
        FROM time_tracking
        WHERE goal_id = ?
        ''',
        [goalId],
      );

      if (goalTimeResult.isNotEmpty && goalTimeResult[0]['total_time'] != null) {
        totalMinutes += goalTimeResult[0]['total_time'] as int;
      }

      // 2. Get all tasks associated with this goal
      final tasks = await db.execute(
        '''
        SELECT id 
        FROM tasks 
        WHERE goal_id = ?
        ''',
        [goalId],
      );

      // 3. Calculate time spent on all tasks of this goal
      for (var task in tasks) {
        final taskTimeResult = await db.execute(
          '''
          SELECT SUM(time_spent) as total_time
          FROM time_tracking
          WHERE task_id = ?
          ''',
          [task['id'].toString()],
        );

        if (taskTimeResult.isNotEmpty && taskTimeResult[0]['total_time'] != null) {
          totalMinutes += taskTimeResult[0]['total_time'] as int;
        }
      }

      // 4. Find all child goals
      final childGoals = await db.execute(
        '''
        SELECT id 
        FROM goals 
        WHERE parent_goal = ?
        ''',
        [goalId],
      );

      // 5. Recursively calculate time for each child goal (including their tasks)
      for (var childGoal in childGoals) {
        String childId = childGoal['id'].toString();
        totalMinutes += await _calculateTotalTimeForGoalAndChildren(childId);
      }

      return totalMinutes;
    } catch (e) {
      print('Error calculating total time: $e');
      return 0;
    }
  }
}
