// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
//
// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/material.dart';
//
// import 'package:TaskRM/src/config/constants.dart';
// import 'package:TaskRM/src/models/goal.dart';
// import 'package:TaskRM/src/providers/goals_list_provider.dart';
//
// class EditGoalsProvider with ChangeNotifier {
//
//   final Databases db;
//   final GoalsListProvider goalsListProvider;
//   EditGoalsProvider({
//     required this.db,
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
//   Future<void> createGoalFromDb({
//     required Goal goal,
//   }) async {
//     try {
//       switchProcessingState(true);
//       await db.createDocument(
//         databaseId: primaryDatabaseId,
//         collectionId: goalsCollectionId,
//         documentId: ID.unique(),
//         data: goal.toMap(),
//       );
//       await goalsListProvider.getGoalsFromDb();
//     } catch (exception) {
//       log("Error Logged in Appwrite call  - $exception");
//     } finally {
//       switchProcessingState(false);
//     }
//   }
//
//   Future<void> deleteDocument(Goal goal) async {
//     try {
//       switchProcessingState(true);
//       await db.deleteDocument(
//         collectionId: goalsCollectionId,
//         databaseId: primaryDatabaseId,
//         documentId: goal.id,
//       );
//       await goalsListProvider.getGoalsFromDb();
//     } catch (exception) {
//       log("Error in deleteDocument $exception");
//     } finally {
//       switchProcessingState(false);
//     }
//   }
// }
