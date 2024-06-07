import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:TaskRM/models/goal.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:TaskRM/utils/custom_snack.dart';
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
    getParentGoalList();
  }

  /// get goal list ///

  late bool _isGoalLoading = false;

  bool get isGoalLoading => _isGoalLoading;

  late List<Goal> _allParentGoalList = [];

  List<Goal> get allParentGoalList => _allParentGoalList;

  late String _selectedFilterType = '';

  String get selectedFilterType => _selectedFilterType;

  void getFilterType(String workType) {
    _selectedFilterType = workType;
    notifyListeners();
  }

  /// for parent goal ///

  // late String _selectedGoal = '';
  //
  // String get selectedGoal => _selectedGoal;
  //
  // late String _selectedGoalId = '';
  //
  // String get selectedGoalId => _selectedGoalId;
  //
  // getSelectedGoal(String goal, String goalId, BuildContext context) {
  //   _selectedGoal = goal;
  //   _selectedGoalId = goalId;
  //   notifyListeners();
  //   //Navigator.pop(context);
  // }

  late String _selectedParentGoal = '';

  String get selectedParentGoal => _selectedParentGoal;

  late String _selectedParentGoalId = '';

  String get selectedParentGoalId => _selectedParentGoalId;

  getSelectedParentGoal(String parentGoal, String parentGoalId, bool isInit,
      BuildContext context) {
    _selectedParentGoal = parentGoal;
    _selectedParentGoalId = parentGoalId;
    notifyListeners();
    //isInit ? null : Navigator.pop(context);
  }

  /// parent goals for goal screen ///
  Future<void> getParentGoalList() async {
    try {
      _isGoalLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          queries: [
            Query.equal("userId", uid),
            Query.equal("parentGoal", '0'),
          ]);

      if (res.documents.isNotEmpty) {
        _allParentGoalList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          if (_selectedFilterType == '') {
            _allParentGoalList.add(Goal(
                id: e.$id ?? '',
                title: e.data['title'] ?? '',
                type: e.data['type'] ?? '',
                description: e.data['description'] ?? '',
                parentGoal: e.data['parentGoal'] ?? '',
                isCompleted: false,
                userId: e.data['userId'] ?? '',
                createdAt: DateTime.parse(e.data['createdAt'])));
            notifyListeners();
          } else if (_selectedFilterType != '') {
            if (e.data['type'] == _selectedFilterType) {
              _allParentGoalList.add(Goal(
                  id: e.$id ?? '',
                  title: e.data['title'] ?? '',
                  type: e.data['type'] ?? '',
                  description: e.data['description'] ?? '',
                  parentGoal: e.data['parentGoal'] ?? '',
                  isCompleted: false,
                  userId: e.data['userId'] ?? '',
                  createdAt: DateTime.parse(e.data['createdAt'])));
              notifyListeners();
            }
          }
        });
      } else {
        // CustomSnack.warningSnack('No task on your queue', context);
        print('No task on your queue');
      }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
      print(e.toString());
    } finally {
      _isGoalLoading = false;
      notifyListeners();
    }
  }


  late bool _isSelectorParentGoalLoading = false;

  bool get isSelectorParentGoalLoading => _isSelectorParentGoalLoading;

  late List<Goal> _selectorParentGoalList = [];

  List<Goal> get selectorParentGoalList => _selectorParentGoalList;

  /// parent goals for creating goal screen ///
  Future<void> parentGoalListForCreatingGoal(String type) async {
    try {
      _isSelectorParentGoalLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          queries: [
            Query.equal("userId", uid),
            Query.equal("parentGoal", '0'),
            Query.equal("type", type),
          ]);

      if (res.documents.isNotEmpty) {
        _selectorParentGoalList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          _selectorParentGoalList.add(Goal(
              id: e.$id ?? '',
              title: e.data['title'] ?? '',
              type: e.data['type'] ?? '',
              description: e.data['description'] ?? '',
              parentGoal: e.data['parentGoal'] ?? '',
              isCompleted: false,
              userId: e.data['userId'] ?? '',
              createdAt: DateTime.parse(e.data['createdAt'])));
          notifyListeners();
        });
      } else {
        // CustomSnack.warningSnack('No task on your queue', context);
        print('No task on your queue');
      }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
      print(e.toString());
    } finally {
      _isSelectorParentGoalLoading = false;
      notifyListeners();
    }
  }

  /// for sub goal ///

  // late String _selectedGoal = '';
  //
  // String get selectedGoal => _selectedGoal;
  //
  // late String _selectedGoalId = '';
  //
  // String get selectedGoalId => _selectedGoalId;
  //
  // getSelectedGoal(String goal, String goalId, BuildContext context) {
  //   _selectedGoal = goal;
  //   _selectedGoalId = goalId;
  //   notifyListeners();
  //   //Navigator.pop(context);
  // }

  late bool _isSubGoalLoading = false;

  bool get isSubGoalLoading => _isSubGoalLoading;

  late List<Goal> _allSubGoalList = [];

  List<Goal> get allSubGoalList => _allSubGoalList;

  Future<void> getSubGoalList(String parentGoalId) async {
    try {
      _isSubGoalLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          queries: [
            Query.equal("userId", uid),
            Query.equal("parentGoal", parentGoalId),
          ]);

      if (res.documents.isNotEmpty) {
        _allSubGoalList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          _allSubGoalList.add(Goal(
              id: e.$id ?? '',
              title: e.data['title'] ?? '',
              type: e.data['type'] ?? '',
              description: e.data['description'] ?? '',
              parentGoal: e.data['parentGoal'] ?? '',
              isCompleted: false,
              userId: e.data['userId'] ?? '',
              createdAt: DateTime.parse(e.data['createdAt'])));
          notifyListeners();
        });
      } else {
        // CustomSnack.warningSnack('No task on your queue', context);
        print('No task on your queue');
      }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
      print(e.toString());
    } finally {
      _isSubGoalLoading = false;
      notifyListeners();
    }
  }

  /// for sub goal list for select sub goal screen ///

  late bool _isSelectorSubGoalLoading = false;

  bool get isSelectorSubGoalLoading => _isSelectorSubGoalLoading;

  late List<Goal> _selectorSubGoalList = [];

  List<Goal> get selectorSubGoalList => _selectorSubGoalList;

  Future<void> subGoalListForCreatingGoal(String parentGoalId, String type) async {
    try {
      _isSelectorSubGoalLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          queries: [
            Query.equal("userId", uid),
            Query.equal("parentGoal", parentGoalId),
            Query.equal("type", type),
          ]);

      if (res.documents.isNotEmpty) {
        _selectorSubGoalList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          _selectorSubGoalList.add(Goal(
              id: e.$id ?? '',
              title: e.data['title'] ?? '',
              type: e.data['type'] ?? '',
              description: e.data['description'] ?? '',
              parentGoal: e.data['parentGoal'] ?? '',
              isCompleted: false,
              userId: e.data['userId'] ?? '',
              createdAt: DateTime.parse(e.data['createdAt'])));
          notifyListeners();
        });
        print('sub goal list ${_selectorSubGoalList.length}');
      } else {
        // CustomSnack.warningSnack('No task on your queue', context);
        print('No task on your queue');
      }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
      print(e.toString());
    } finally {
      _isSelectorSubGoalLoading = false;
      notifyListeners();
    }
  }

  /// get task list with parent goal id ///

  late bool _isGoalAllTaskLoading = false;

  bool get isGoalAllTaskLoading => _isGoalAllTaskLoading;

  late List<Task> _allGoalTaskList = [];

  List<Task> get allGoalTaskList => _allGoalTaskList;

  Future<void> getAllGoalTaskList(String goalId) async {
    try {
      _isGoalAllTaskLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.taskCollectionId,
          queries: [
            Query.equal("userID", uid),
            Query.equal("goalId", goalId),
          ]);

      if (res.documents.isNotEmpty) {
        _allGoalTaskList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          _allGoalTaskList.add(Task(
              id: e.$id ?? '',
              title: e.data['title'] ?? '',
              type: e.data['type'] ?? '',
              priority: e.data['priority'] ?? '',
              timeframe: e.data['timeframe'] ?? '',
              //timeframe: timeFrameResult,
              description: e.data['description'] ?? '',
              createdAt: DateTime.parse(e.data['createdAt']),
              expectedCompletion: DateTime.parse(e.data['expectedCompletion']),
              goalId: e.data['goalId'] ?? '',
              isMarkedForToday: false,
              jiraID: e.data['jiraID'] ?? '',
              userID: e.data['userID'] ?? '',
              goal: e.data['goal'] ?? ''));
          notifyListeners();
        });
      } else {
        //CustomSnack.warningSnack('No task on your queue', context);
      }
    } catch (e) {
      // CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isGoalAllTaskLoading = false;
      notifyListeners();
    }
  }

  /// add task state ///

  late bool _isGoalAdding = false;

  bool get isGoalAdding => _isGoalAdding;

  Future<void> addNewGoal(String title, String description, String type,
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
            'title': title,
            'userId': uid,
            'description': description,
            'type': type,
            'parentGoal': _selectedParentGoalId,
            'createdAt': DateTime.now().toString()
          }).then((value) {
        Navigator.pop(context);
        CustomSnack.successSnack('Goal added successfully.', context);
        getParentGoalList();
        _selectedParentGoal = '';
        _selectedParentGoalId = '';
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      _isGoalAdding = false;
      notifyListeners();
    }
  }

  /// goal editing state ///

  late bool isGoalEditing = false;

  Future<void> editGoal(String docId, String title, String description,
      String type, BuildContext context) async {
    try {
      isGoalEditing = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      var res = await db.updateDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          documentId: docId,
          data: {
            'title': title,
            'userId': uid,
            'description': description,
            'type': type,
            'parentGoal': _selectedParentGoal,
            'createdAt': DateTime.now().toString()
          }).then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        CustomSnack.successSnack('Goal is edited successfully.', context);
        getParentGoalList();
      });
      notifyListeners();
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isGoalEditing = false;
      notifyListeners();
    }
  }
}
