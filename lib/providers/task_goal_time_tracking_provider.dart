import 'package:TaskRM/utils/assets_path.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:TaskRM/utils/custom_snack.dart';
import '../models/task.dart';
import '../utils/config/constants.dart';

class TaskGoalTimeTrackingProvider extends ChangeNotifier {
  TaskGoalTimeTrackingProvider() {
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









  /// add task state ///

  late bool isTimeSpentAdding = false;

  Future<void> addTimeSpent(
      String goalId,
      String taskId,
      String startTime,
      String stopTime,
      String timeSpent,
      BuildContext context) async {
    try {
      isTimeSpentAdding = true;
      notifyListeners();

      final uid = await AppStorage.getUserId();

      var res = await db.createDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.timeTrackingCollectionId,
          documentId: ID.unique(),
          data: {
            'userID': uid,
            'goalID': goalId,
            'taskID': taskId,
            'entryDate': DateTime.now().toString(),
            'startTime': startTime,
            'stopTime': stopTime,
            'timeSpent': timeSpent,
          });

      if(res.data.isNotEmpty){
        Navigator.pop(context);
        Navigator.pop(context);
        CustomDialog.autoDialog(
            context, Icons.check, 'Your tracking time is submitted');
      }

      notifyListeners();
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isTimeSpentAdding = false;
      notifyListeners();
    }
  }

  /// edit task state ///
  //
  // late bool isTaskEditing = false;
  //
  // Future<void> editTask(
  //     String docId,
  //     String title,
  //     String type,
  //     String goalId,
  //     String priority,
  //     String timeFrame,
  //     String description,
  //     String goal,
  //     BuildContext context) async {
  //   try {
  //     isTaskEditing = true;
  //     notifyListeners();
  //
  //     final uid = await AppStorage.getUserId();
  //
  //     var res = await db.updateDocument(
  //         databaseId: AppWriteConstant.primaryDBId,
  //         collectionId: AppWriteConstant.taskCollectionId,
  //         documentId: docId,
  //         data: {
  //           'timeframe': timeFrame,
  //           'jiraID': '',
  //           'title': title,
  //           'type': type,
  //           'isMarkedForToday': timeFrame == '1' ? true : false,
  //           'goalId': goalId,
  //           'priority': priority,
  //           'description': description,
  //           'userID': uid,
  //           'goal': goal,
  //           'createdAt': DateTime.now().toString(),
  //           'expectedCompletion':
  //           getExpectedDateFromTimeframe(timeFrame).toString(),
  //         }).then((value) {
  //       Navigator.pop(context);
  //       Navigator.pop(context);
  //       CustomDialog.autoDialog(
  //           context, Icons.check, 'Task is edited successfully!');
  //       getTodayTaskList();
  //       getAllTaskList();
  //     });
  //     notifyListeners();
  //
  //     // if (res.data.isNotEmpty) {
  //     //   _allFeedList.clear();
  //     //   notifyListeners();
  //     //   getFeedList();
  //     //   // Navigator.pushNamed(context, Routes.moments);
  //     // }
  //   } catch (e) {
  //     CustomSnack.warningSnack(e.toString(), context);
  //   } finally {
  //     isTaskEditing = false;
  //     notifyListeners();
  //   }
  // }



}
