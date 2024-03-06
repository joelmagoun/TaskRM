import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:task_rm/utils/app_storage.dart';
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
    getTaskList();
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

  getSelectedGoal(String goal, BuildContext context) {
    _selectedGoal = goal;
    notifyListeners();
    Navigator.pop(context);
  }

  /// get task list ///

  late bool _isTaskLoading = false;
  bool get isTaskLoading => _isTaskLoading;

  late List<Task> _allTaskList = [];
  List<Task> get allTaskList => _allTaskList;

  late List<Task> _todayTaskList = [];
  List<Task> get todayTaskList => _todayTaskList;


  /// for filter  ///
  late String _selectedFilterType = '';
  String get selectedFilterType => _selectedFilterType;

  void getFilterType(String workType){
    _selectedFilterType = workType;
    notifyListeners();
  }


  Future<void> getTaskList() async {
    try {

      _isTaskLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.taskCollectionId,
          queries: [Query.equal("userID", uid)]);

      if (res.documents.isNotEmpty) {
        
        _allTaskList.clear();
        notifyListeners();
        _todayTaskList.clear();
        notifyListeners();
        
        res.documents.forEach((e) {
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
              goal: e.data['goal'] ?? ''
          ));
          notifyListeners();

          if(e.data['timeframe'] == 'Today'){

            if(_selectedFilterType == ''){
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
                  goal: e.data['goal'] ?? ''
              ));
              notifyListeners();
            }else if(_selectedFilterType != ''){
              if(e.data['type'] == _selectedFilterType){
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
                    goal: e.data['goal'] ?? ''
                ));
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
    }finally{
      _isTaskLoading = false;
      notifyListeners();
    }
  }

  /// add task state ///

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
            'isMarkedForToday': false,
            'goalId': '',
            'priority': priority,
            'description': description,
            'userID': uid,
            'goal': goal,
            'createdAt': DateTime.now().toString()
          }).then((value) {
            Navigator.pop(context);
        CustomSnack.successSnack('Task is added successfully!', context);
            getTaskList();
      });
      notifyListeners();

      // if (res.data.isNotEmpty) {
      //   _allFeedList.clear();
      //   notifyListeners();
      //   getFeedList();
      //   // Navigator.pushNamed(context, Routes.moments);
      // }
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isTaskAdding = false;
      notifyListeners();
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
        CustomSnack.successSnack('Task is moved to today task list successfully!', context);
        getTaskList();
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
