// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
//
// import 'package:TaskRM/src/utils/constant.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/material.dart';
//
// import 'package:TaskRM/src/config/constants.dart';
//
// import 'package:TaskRM/src/models/goal.dart';
//
// class GoalsListProvider with ChangeNotifier {
//   final Databases db;
//   GoalsListProvider({
//     required this.db,
//   });
//
//   List<Goal> _goals = [];
//   List<Goal> visibleGoals = [];
//   bool isLoadingGoals = true;
//
//   ValueNotifier<String?> selectedTypeFilter = ValueNotifier(null);
//
//   List<String> typeFilters = ["Work", "Personal", "Self"];
//
//   reset() {
//     selectedTypeFilter.value = null;
//   }
//
//   Future<List<Goal>> getGoalsFromDb() async {
//     try {
//
//       final uid = await storage.read(key: 'userId');
//       isLoadingGoals = true;
//       notifyListeners();
//       final response = await db.listDocuments(
//           databaseId: primaryDatabaseId,
//           collectionId: goalsCollectionId,
//           queries: [
//             Query.equal("isCompleted", false),
//             Query.equal("userId", uid)
//           ]);
//
//       List<Goal> models = [];
//
//       for (var t in response.documents) {
//         models.add(Goal.fromAppwriteDoc(t));
//       }
//       visibleGoals = [...models];
//       return _goals = [...models];
//     } catch (exception) {
//       log("Error Logged in Appwrite call  - $exception");
//       return [];
//     } finally {
//       isLoadingGoals = false;
//       notifyListeners();
//     }
//   }
//
//   void filterGoalsByType(String type) {
//     final g = _goals.where((element) {
//       return element.type.toLowerCase().contains(type.toLowerCase());
//     }).toList();
//     visibleGoals = [...g];
//     selectedTypeFilter.value = type;
//     notifyListeners();
//   }
// }
