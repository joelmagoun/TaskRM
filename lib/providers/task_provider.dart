import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:task_rm/utils/app_storage.dart';
import 'package:task_rm/utils/custom_dialog.dart';
import 'package:task_rm/utils/custom_snack.dart';
import '../models/task.dart';
import '../utils/config/constants.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    _init();
  }

  Client client = Client();
  late Databases db;

  _init() {
    client
        .setEndpoint(AppWriteConstant.endPoint)
        .setProject(AppWriteConstant.projectId);
    db = Databases(client);
    getTodayTaskList();
    getAllTaskList();
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

  late String _selectedGoalId = '';

  String get selectedGoalId => _selectedGoalId;

  getSelectedGoal(String goal, String goalId, BuildContext context) {
    _selectedGoal = goal;
    _selectedGoalId = goalId;
    notifyListeners();
    //Navigator.pop(context);
  }

  /// get today task list ///

  late bool _isTaskLoading = false;

  bool get isTaskLoading => _isTaskLoading;

  late List<Task> _todayTaskList = [];

  List<Task> get todayTaskList => _todayTaskList;

  /// for filter  ///
  late String _selectedFilterType = '';

  String get selectedFilterType => _selectedFilterType;

  void getFilterType(String workType) {
    _selectedFilterType = workType;
    notifyListeners();
  }

  Future<void> getTodayTaskList() async {
    try {
      _isTaskLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.taskCollectionId,
          queries: [Query.equal("userID", uid)]);

      if (res.documents.isNotEmpty) {
        _todayTaskList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          if (e.data['timeframe'] == 'Today') {
            if (_selectedFilterType == '') {
              _todayTaskList.add(Task(
                  id: e.$id ?? '',
                  title: e.data['title'] ?? '',
                  type: e.data['type'] ?? '',
                  priority: e.data['priority'] ?? '',
                  timeframe: e.data['timeframe'] ?? '',
                  description: e.data['description'] ?? '',
                  createdAt: DateTime.parse(e.data['createdAt']),
                  expectedCompletion: DateTime.now(),
                  isMarkedForToday: false,
                  jiraID: e.data['jiraID'] ?? '',
                  userID: e.data['userID'] ?? '',
                  goal: e.data['goal'] ?? ''));
              notifyListeners();
            } else if (_selectedFilterType != '') {
              if (e.data['type'] == _selectedFilterType) {
                _todayTaskList.add(Task(
                    id: e.$id ?? '',
                    title: e.data['title'] ?? '',
                    type: e.data['type'] ?? '',
                    priority: e.data['priority'] ?? '',
                    timeframe: e.data['timeframe'] ?? '',
                    description: e.data['description'] ?? '',
                    createdAt: DateTime.parse(e.data['createdAt']),
                    expectedCompletion: DateTime.now(),
                    isMarkedForToday: false,
                    jiraID: e.data['jiraID'] ?? '',
                    userID: e.data['userID'] ?? '',
                    goal: e.data['goal'] ?? ''));
                notifyListeners();
              }
            }
          }
        });
      } else {
        // CustomSnack.warningSnack('No task on your queue', context);
      }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
      print(e.toString());
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

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.taskCollectionId,
          queries: [Query.equal("userID", uid)]);

      if (res.documents.isNotEmpty) {
        _allTaskList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          if (e.data['timeframe'] != 'Today') {
            if (_selectedQueueTimeFrame == '' || _selectedQueueType == '') {
              _allTaskList.add(Task(
                  id: e.$id ?? '',
                  title: e.data['title'] ?? '',
                  type: e.data['type'] ?? '',
                  priority: e.data['priority'] ?? '',
                  timeframe: e.data['timeframe'] ?? '',
                  description: e.data['description'] ?? '',
                  createdAt: DateTime.parse(e.data['createdAt']),
                  expectedCompletion: DateTime.now(),
                  isMarkedForToday: false,
                  jiraID: e.data['jiraID'] ?? '',
                  userID: e.data['userID'] ?? '',
                  goal: e.data['goal'] ?? ''));
              notifyListeners();
            } else if (_selectedQueueTimeFrame != '' ||
                _selectedQueueType != '') {
              if (e.data['type'] == _selectedQueueType &&
                  e.data['timeframe'] == _selectedQueueTimeFrame) {
                _allTaskList.add(Task(
                    id: e.$id ?? '',
                    title: e.data['title'] ?? '',
                    type: e.data['type'] ?? '',
                    priority: e.data['priority'] ?? '',
                    timeframe: e.data['timeframe'] ?? '',
                    description: e.data['description'] ?? '',
                    createdAt: DateTime.parse(e.data['createdAt']),
                    expectedCompletion: DateTime.now(),
                    isMarkedForToday: false,
                    jiraID: e.data['jiraID'] ?? '',
                    userID: e.data['userID'] ?? '',
                    goal: e.data['goal'] ?? ''));
                notifyListeners();
              }
            }
          }
        });
      } else {
        // CustomSnack.warningSnack('No task on your queue', context);
      }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isAllTaskLoading = false;
      notifyListeners();
    }
  }

  /// add task state ///

  Future<void> addNewTask(
      String title,
      String type,
      String goalId,
      String priority,
      String timeFrame,
      String description,
      String goal,
      BuildContext context) async {
    try {
      _isTaskAdding = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      var res = await db.createDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.taskCollectionId,
          documentId: ID.unique(),
          data: {
            'timeframe': timeFrame,
            'jiraID': '',
            'title': title,
            'type': type,
            'isMarkedForToday': timeFrame == 'Today' ? true : false,
            'goalId': goalId,
            'priority': priority,
            'description': description,
            'userID': uid,
            'goal': goal,
            'createdAt': DateTime.now().toString(),
            'expectedCompletion': getExpectedDateFromTimeframe(timeFrame).toString(),
          }).then((value) {
        Navigator.pop(context);
        CustomDialog.autoDialog(context, Icons.check, 'Task is added successfully!');
        getTodayTaskList();
        getAllTaskList();
      });
      notifyListeners();

      // if (res.data.isNotEmpty) {
      //   _allFeedList.clear();
      //   notifyListeners();
      //   getFeedList();
      //   // Navigator.pushNamed(context, Routes.moments);
      // }
    } catch (e) {
      print('catch error ${e.toString()}');
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isTaskAdding = false;
      notifyListeners();
    }
  }

  DateTime getExpectedDateFromTimeframe(String timeFrame) {
    final now = DateTime.now();

    switch (timeFrame) {
      case "Today":
        return now.add(const Duration(days: 1));
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

  /// move to today task list ///

  late bool _isMoving = false;

  bool get isMoving => _isMoving;

  Future<void> moveToTodayTaskList(
      String taskId,
      String title,
      String type,
      String priority,
      String description,
      String goal,
      String createdAt,
      BuildContext context) async {
    try {
      _isMoving = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      var res = await db.updateDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.taskCollectionId,
          documentId: taskId,
          data: {
            'timeframe': 'Today',
            'jiraID': '',
            'title': title,
            'type': type,
            'isMarkedForToday': false,
            'goalId': '',
            'priority': priority,
            'description': description,
            'userID': uid,
            'goal': goal,
            'createdAt': createdAt
          }).then((value) {
        Navigator.pop(context);
        CustomSnack.successSnack(
            'Task is moved to today task list successfully!', context);
        getTodayTaskList();
        getAllTaskList();
      });
      notifyListeners();
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isMoving = false;
      notifyListeners();
    }
  }
}
