// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// import 'package:TaskRM/src/providers/goals_list_provider.dart';
// import 'package:TaskRM/src/providers/tasks_list_provider.dart';
//
// class HomeProvider with ChangeNotifier {
//   final TasksListProvider tasksListProvider;
//   final GoalsListProvider goalsListProvider;
//   HomeProvider({
//     required this.tasksListProvider,
//     required this.goalsListProvider,
//   });
//
//   bool loading = true;
//
//   List<int> menuItemsCount = [];
//
//   init() async {
//     try {
//       loading = true;
//       notifyListeners();
//       final response = await Future.wait([
//         tasksListProvider.getTasksFromDb(),
//         goalsListProvider.getGoalsFromDb(),
//       ]);
//       menuItemsCount = [];
//       for (final list in response) {
//         menuItemsCount.add(list.length);
//       }
//     } catch (exception) {
//       log("Error in init() homeprovider ", error: exception);
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
// }
