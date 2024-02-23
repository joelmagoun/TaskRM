// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
//
// import 'package:TaskRM/src/utils/constant.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/material.dart';
//
// import 'package:TaskRM/src/config/constants.dart';
//
// import 'package:TaskRM/src/models/task.dart';
//
// class TodayTasksListProvider with ChangeNotifier {
//   final Databases db;
//   TodayTasksListProvider({
//     required this.db,
//   });
//
//   List<Task> tasks = [];
//   bool isLoadingTasks = true;
//
//   Future<List<Task>> getTodayTasksFromDb() async {
//     try {
//
//       final uid = await storage.read(key: 'userId');
//       isLoadingTasks = true;
//       notifyListeners();
//       final response = await db.listDocuments(
//           databaseId: primaryDatabaseId,
//           collectionId: tasksCollectionId,
//           queries: [
//             Query.equal("isMarkedForToday", true),
//             Query.equal("isCompleted", false),
//             Query.equal("userID", uid)
//           ]);
//
//       List<Task> models = [];
//
//       for (var t in response.documents) {
//         models.add(Task.fromAppwriteDoc(t));
//       }
//
//       return tasks = models;
//     } catch (exception) {
//       log("Error Logged in Appwrite call  - $exception");
//       return [];
//     } finally {
//       isLoadingTasks = false;
//       notifyListeners();
//     }
//   }
//
// }
