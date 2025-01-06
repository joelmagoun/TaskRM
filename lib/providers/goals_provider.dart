import 'dart:math';

import 'package:flutter/material.dart';
import 'package:TaskRM/models/goal.dart';
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
        ORDER BY created_at DESC
      """;

      print('Goals Query: $query'); // Debug
      
      final results = await db.getAll(query);
      print('Query results: ${results.length} goals found'); // Debug
      
      _allGoalList.clear();
      
      results.forEach((e) {
        print('Goal: ${e['title']}, is_completed: ${e['is_completed']}'); // Debug
        _allGoalList.add(Goal(
          id: e['id'] ?? '',
          title: e['title'] ?? '',
          type: e['type'] ?? '',
          description: e['description'] ?? '',
          isCompleted: e['is_completed'] ?? 0,
          userId: e['user_id'] ?? '',
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
      String parentGoal, BuildContext context) async {
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
            parentGoal,
            0  // Default to not completed
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
}
