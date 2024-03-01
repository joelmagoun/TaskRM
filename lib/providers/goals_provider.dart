import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:task_rm/models/goal.dart';
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
    getGoalList();
  }


  /// get goal list ///

  late bool _isGoalLoading = false;

  bool get isGoalLoading => _isGoalLoading;

  late List<Goal> _allGoalList = [];

  List<Goal> get allGoalList => _allGoalList;

  Future<void> getGoalList() async {
    try {
      _isGoalLoading = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.goalCollectionId,
          queries: [Query.equal("userId", uid)]);

      if (res.documents.isNotEmpty) {

        _allGoalList.clear();
        notifyListeners();

        res.documents.forEach((e) {
          _allGoalList.add(
              Goal(id: e.$id ?? '',
                  title: e.data['title'] ?? '',
                  type: e.data['type'] ?? '',
                  description: e.data['description'] ?? '',
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
      _isGoalLoading = false;
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

  Future<void> addNewGoal(String title,
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

}
