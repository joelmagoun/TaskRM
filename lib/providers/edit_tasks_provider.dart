// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
//
// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/material.dart';
//
// import 'package:TaskRM/src/config/constants.dart';
// import 'package:TaskRM/src/models/goal.dart';
// import 'package:TaskRM/src/models/task.dart';
// import 'package:TaskRM/src/providers/goals_list_provider.dart';
// import 'package:TaskRM/src/providers/tasks_list_provider.dart';
//
// class EditTaskProvider with ChangeNotifier {
//   final Databases db;
//   final TasksListProvider tasksListProvider;
//   final GoalsListProvider goalsListProvider;
//   ValueNotifier isGoalsUpdating = ValueNotifier(true);
//   List<Goal> goalsForDropdown = [];
//   List<Goal> allGoals = [];
//   Goal? chosenGoal;
//
//   EditTaskProvider({
//     required this.db,
//     required this.tasksListProvider,
//     required this.goalsListProvider,
//   });
//
//   bool isProcessing = false;
//
//   void switchProcessingState(bool newState) {
//     isProcessing = newState;
//     notifyListeners();
//   }
//
//   Future<List<Goal>> getGoalsForDropdown() async {
//     try {
//       isGoalsUpdating.value = true;
//       goalsForDropdown = [];
//       allGoals = await goalsListProvider.getGoalsFromDb();
//       return goalsForDropdown = allGoals;
//     } catch (exception) {
//       return [];
//     } finally {
//       isGoalsUpdating.value = false;
//     }
//   }
//
//   void updateGoals(String typeOfTaskChosen) {
//     chosenGoal = null;
//     goalsForDropdown = [];
//     isGoalsUpdating.value = true;
//     Future.delayed(const Duration(milliseconds: 500), () {
//       goalsForDropdown = allGoals
//           .where((element) =>
//               element.type.toLowerCase() == typeOfTaskChosen.toLowerCase())
//           .toList();
//       isGoalsUpdating.value = false;
//     });
//   }
//
//   Future<void> createTaskFromDb({
//     required Task task,
//   }) async {
//     try {
//       switchProcessingState(true);
//       await db.createDocument(
//         databaseId: primaryDatabaseId,
//         collectionId: tasksCollectionId,
//         documentId: ID.unique(),
//         data: task.toMap(),
//       );
//       await tasksListProvider.getTasksFromDb();
//     } catch (exception) {
//       log("Error Logged in Appwrite call  - $exception");
//     } finally {
//       switchProcessingState(false);
//     }
//   }
//
//   Future<void> deleteDocument(Task task) async {
//     try {
//       switchProcessingState(true);
//       await db.deleteDocument(
//         collectionId: tasksCollectionId,
//         databaseId: primaryDatabaseId,
//         documentId: task.id,
//       );
//       await tasksListProvider.getTasksFromDb();
//     } catch (exception) {
//       log("Error in deleteDocument $exception");
//     } finally {
//       switchProcessingState(false);
//     }
//   }
// }
