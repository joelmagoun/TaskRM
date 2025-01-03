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

      /// ******* /////

      db
          .watch(
          "SELECT * FROM goals Where user_id = '$uid' ORDER BY created_at DESC")
          .map((results) {
        if (results.isNotEmpty) {
          _allGoalList.clear();
          notifyListeners();
          return results.map((e) {

            print('all goals kafiul ${e}');
                if(_selectedFilterType == ''){
                  _allGoalList.add(Goal(
                      id: e['id'] ?? '',
                      title: e['title'] ?? '',
                      type: e['type'] ?? '',
                      description: e['description'] ?? '',
                      isCompleted: false,
                      userId: e['user_id'] ?? '',
                      createdAt: DateTime.parse(e['created_at'])));
                  notifyListeners();
                }else{
                  if(e['type'] == _selectedFilterType){
                    _allGoalList.add(Goal(
                        id: e['id'] ?? '',
                        title: e['title'] ?? '',
                        type: e['type'] ?? '',
                        description: e['description'] ?? '',
                        isCompleted: false,
                        userId: e['user_id'] ?? '',
                        createdAt: DateTime.parse(e['created_at'])));
                    notifyListeners();
                  }}

            /// ******* /////
            // if (_selectedQueueTimeFrame == '' || _selectedQueueType == '') {
            //   _allTaskList.add(TaskModel(
            //     id: e['id'] ?? 0,
            //     createdAt: e['created_at'] ?? '',
            //     updatedAt: e['updated_at'] ?? '',
            //     timeframe: e['timeframe'] ?? '',
            //     jiraId: e['jira_id'] ?? '',
            //     title: e['title'] ?? '',
            //     type: e['type'] ?? '',
            //     isMarkedForToday: e['is_marked_for_today'] ?? false,
            //     goalId: e['goal_id'] ?? '',
            //     priority: e['priority'] ?? '',
            //     description: e['description'] ?? '',
            //     userId: e['user_id'] ?? '',
            //     goal: e['goal'] ?? '',
            //     expectedCompletion: e['expected_completion'] ?? '',
            //     isCompleted: e['is_completed'] ?? false,
            //     totalMinutesSpent: e['total_minutes_spent'] ?? 0,
            //   ));
            //   notifyListeners();
            // } else if (_selectedQueueTimeFrame != '' ||
            //     _selectedQueueType != '') {
            //   if (e['type'] == _selectedQueueType &&
            //       e['timeframe'] == _selectedQueueTimeFrame) {
            //     _allTaskList.add(TaskModel(
            //       id: e['id'] ?? 0,
            //       createdAt: e['created_at'] ?? '',
            //       updatedAt: e['updated_at'] ?? '',
            //       timeframe: e['timeframe'] ?? '',
            //       jiraId: e['jira_id'] ?? '',
            //       title: e['title'] ?? '',
            //       type: e['type'] ?? '',
            //       isMarkedForToday: e['is_marked_for_today'] ?? false,
            //       goalId: e['goal_id'] ?? '',
            //       priority: e['priority'] ?? '',
            //       description: e['description'] ?? '',
            //       userId: e['user_id'] ?? '',
            //       goal: e['goal'] ?? '',
            //       expectedCompletion: e['expected_completion'] ?? '',
            //       isCompleted: e['is_completed'] ?? false,
            //       totalMinutesSpent: e['total_minutes_spent'] ?? 0,
            //     ));
            //     notifyListeners();
            //   }
            // }

            /// ******* /////
            notifyListeners();
          }).toList();
        }
      }).toList();

      /// ******* /////

      // final res = await db.listDocuments(
      //     databaseId: AppWriteConstant.primaryDBId,
      //     collectionId: AppWriteConstant.goalCollectionId,
      //     queries: [
      //       Query.equal("userId", uid),
      //     ]);

      // if (res.documents.isNotEmpty) {
      //   _allGoalList.clear();
      //   notifyListeners();
      //
      //   res.documents.forEach((e) {
      //
      //     if(_selectedFilterType == ''){
      //       _allGoalList.add(Goal(
      //           id: e.$id ?? '',
      //           title: e.data['title'] ?? '',
      //           type: e.data['type'] ?? '',
      //           description: e.data['description'] ?? '',
      //           isCompleted: false,
      //           userId: e.data['userId'] ?? '',
      //           createdAt: DateTime.parse(e.data['createdAt'])));
      //       notifyListeners();
      //     }else if(_selectedFilterType != ''){
      //       if(e.data['type'] == _selectedFilterType){
      //         _allGoalList.add(Goal(
      //             id: e.$id ?? '',
      //             title: e.data['title'] ?? '',
      //             type: e.data['type'] ?? '',
      //             description: e.data['description'] ?? '',
      //             isCompleted: false,
      //             userId: e.data['userId'] ?? '',
      //             createdAt: DateTime.parse(e.data['createdAt'])));
      //         notifyListeners();
      //       }
      //
      //     }
      //
      // //   });
      // } else {
      //   // CustomSnack.warningSnack('No task on your queue', context);
      //   print('No task on your queue');
      // }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
      print(e.toString());
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

      var result = await db.writeTransaction((tx) async {
        await tx.execute(
            'INSERT INTO goals( id, created_at, updated_at, title, user_id, description, type, parent_goal) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
            [
              docIdForPower.toString(),
              DateTime.now().toIso8601String(),
              DateTime.now().toIso8601String(),
              title,
              uid,
              description,
              type,
              parentGoal,
            ]);
      });

      Navigator.pop(context);
      // await getTodayTaskList();
      // await getAllTaskList();
      //
      CustomDialog.autoDialog(
          context, Icons.check, 'Goal is added successfully!');
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isGoalAdding = false;
      notifyListeners();
    }
  }
}
