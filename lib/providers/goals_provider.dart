import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:TaskRM/models/goal.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:TaskRM/utils/custom_snack.dart';
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

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          queries: [
            Query.equal("userId", uid),
          ]);

      if (res.documents.isNotEmpty) {
        _allGoalList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          if (_selectedFilterType == '') {
            _allGoalList.add(Goal(
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
              _allGoalList.add(Goal(
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

  /// add task state ///

  late bool _isGoalAdding = false;

  bool get isGoalAdding => _isGoalAdding;

  late String _selectedParentGoal = 'Select';

  String get selectedParentGoal => _selectedParentGoal;

  getSelectedParentGoal(String parentGoal, bool isInit, BuildContext context) {
    _selectedParentGoal = parentGoal;
    notifyListeners();
    isInit ? null : Navigator.pop(context);
  }

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
            'parentGoal': _selectedParentGoal,
            'createdAt': DateTime.now().toString()
          }).then((value) {
        Navigator.pop(context);
        CustomSnack.successSnack('Goal added successfully.', context);
        getGoalList();
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

  Future<void> editGoal(String docId, String title, String description, String type,
      BuildContext context) async {
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
        getGoalList();
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
