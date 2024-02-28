import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:task_rm/utils/app_storage.dart';
import 'package:task_rm/utils/custom_snack.dart';

import '../utils/config/constants.dart';

class NewTaskProvider extends ChangeNotifier {
  NewTaskProvider() {
    _init();
  }

  Client client = Client();
  late Databases db;

  _init() {
    client
        .setEndpoint(AppWriteConstant.endPoint)
        .setProject(AppWriteConstant.projectId);
    db = Databases(client);
  }

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

  late String _selectedGoal = 'Select';

  String get selectedGoal => _selectedGoal;

  getSelectedGoal(String goal, BuildContext context){
    _selectedGoal = goal;
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> addNewTask(
     String title,
      String type,
      String priority,
      String timeFrame,
      String description,
      String goal,
      BuildContext context) async {
    try {

      _isTaskAdding = true;
      notifyListeners();

      final uid = AppStorage.getUserId();

      var res = await db.createDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.taskCollectionId,
          documentId: ID.unique(),
          data: {
            'timeframe': timeFrame,
            'isCompleted': false,
            'createdAt': DateTime.now(),
            'jiraID': '',
            'title': title,
            'totalMinutesSpent': 00,
            'updatedAt': DateTime.now(),
            'type': type,
            'isMarkedForToday': false,
            'goalId': '',
            'expectedCompletion': DateTime.now(),
            'priority': priority,
            'description': description,
            'userID': uid,
            'goal': goal,
      }).then((value) {
        CustomSnack.successSnack('task is posted successfuly', context);
        print(value.data);
      });
      notifyListeners();

      // if (res.data.isNotEmpty) {
      //   _allFeedList.clear();
      //   notifyListeners();
      //   getFeedList();
      //   // Navigator.pushNamed(context, Routes.moments);
      // }
    } catch (e) {
      print(e.toString());
    }finally{
      _isTaskAdding = false;
      notifyListeners();
    }
  }
}
