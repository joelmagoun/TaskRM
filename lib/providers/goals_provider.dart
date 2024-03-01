import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:task_rm/utils/app_storage.dart';
import 'package:task_rm/utils/custom_snack.dart';
import '../models/task.dart';
import '../utils/config/constants.dart';

class GoalProvider extends ChangeNotifier {
  GoalProvider() {
    _init();
  }

  Client client = Client();
  late Databases db;

  _init() {
    client
        .setEndpoint(AppWriteConstant.endPoint)
        .setProject(AppWriteConstant.projectId);
    db = Databases(client);
    //getTaskList();
  }


  /// get goal list ///

  late bool _isTaskLoading = false;
  bool get isTaskLoading => _isTaskLoading;

  late List<Task> _allTaskList = [];
  List<Task> get allTaskList => _allTaskList;

  late List<Task> _todayTaskList = [];
  List<Task> get todayTaskList => _todayTaskList;

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
              createdAt: DateTime.now(),
              expectedCompletion: DateTime.now(),
              isMarkedForToday: false,
              jiraID: e.data['jiraID'] ?? '',
              userID: e.data['userID'] ?? '',
              goal: e.data['goal'] ?? ''
          ));
          notifyListeners();

          if(e.data['timeframe'] == 'Today'){
            _todayTaskList.add(Task(
                id: e.$id ?? '',
                title: e.data['title'] ?? '',
                type: e.data['type'] ?? '',
                priority: e.data['priority'] ?? '',
                timeframe: e.data['timeframe'] ?? '',
                description: e.data['description'] ?? '',
                createdAt: DateTime.now(),
                expectedCompletion: DateTime.now(),
                isMarkedForToday: false,
                jiraID: e.data['jiraID'] ?? '',
                userID: e.data['userID'] ?? '',
                goal: e.data['goal'] ?? ''
            ));
            notifyListeners();
          }

        });
      } else {
        // CustomSnack.warningSnack('No task on your queue', context);
        print('No task on your queue');
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

  late bool _isGoalAdding = false;

  bool get isGoalAdding => _isGoalAdding;

  late String _selectedParentGoal = 'Select';

  String get selectedParentGoal => _selectedParentGoal;

  getSelectedParentGoal(String parentGoal, BuildContext context) {
    _selectedParentGoal = parentGoal;
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> addNewGoal(
      String title,
      String description,
      String type,
      BuildContext context) async {
    try {
      _isGoalAdding = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      var res = await db.createDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          documentId: ID.unique(),
          data: {
            'createdAt': DateTime.now(),
            'updatedAt': DateTime.now(),
            'title': title,
            'userId': uid,
            'description': description,
            'isCompleted': false,
            'totalMinutesSpent': 00,
            'type': type,
          }).then((value) {
        Navigator.pop(context);
        CustomSnack.successSnack('Goal added successfully.', context);
       // getTaskList();
        print('task added two ');
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
      _isGoalAdding = false;
      notifyListeners();
    }
  }

}
