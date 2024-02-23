// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
//
// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/material.dart';
// import 'package:TaskRM/src/config/constants.dart';
//
// import 'package:TaskRM/src/models/goal.dart';
// import 'package:TaskRM/src/models/task.dart';
//
// class TaskDetailsProvider with ChangeNotifier {
//   final Databases db;
//   TaskDetailsProvider({
//     required this.db,
//   });
//
//   ValueNotifier<Goal?> goal = ValueNotifier(null);
//   ValueNotifier<Task?> task = ValueNotifier(null);
//   ValueNotifier<bool> isLoadingTaskAndGoal = ValueNotifier(true);
//   ValueNotifier<bool> isMarkingTaskForToday = ValueNotifier(false);
//   ValueNotifier<bool> isTogglingTaskStatus = ValueNotifier(false);
//   ValueNotifier<bool> isCompleted = ValueNotifier(false);
//
//   init(String taskId, [String? goalId]) {
//     fetchTaskAndGoal(taskId, goalId);
//   }
//
//   reset() {
//     isCompleted.value = false;
//     task.value = null;
//     goal.value = null;
//     isTogglingTaskStatus.value = false;
//     isLoadingTaskAndGoal.value = true;
//   }
//
//   Future<bool> markTaskForToday(Task task) async {
//     try {
//       isMarkingTaskForToday.value = true;
//
//       await db.updateDocument(
//         databaseId: primaryDatabaseId,
//         collectionId: tasksCollectionId,
//         documentId: task.id,
//         data: task
//             .copyWith(
//               isMarkedForToday: true,
//               updatedAt: DateTime.now(),
//             )
//             .toMap(),
//       );
//       return true;
//     } catch (exception) {
//       return false;
//     } finally {
//       isMarkingTaskForToday.value = false;
//     }
//   }
//
//   Future<bool> removeTaskForToday(Task task) async {
//     try {
//       isMarkingTaskForToday.value = true;
//
//       await db.updateDocument(
//         databaseId: primaryDatabaseId,
//         collectionId: tasksCollectionId,
//         documentId: task.id,
//         data: task
//             .copyWith(
//               isMarkedForToday: false,
//               updatedAt: DateTime.now(),
//             )
//             .toMap(),
//       );
//       return true;
//     } catch (exception) {
//       return false;
//     } finally {
//       isMarkingTaskForToday.value = false;
//     }
//   }
//
//   Future<void> fetchTaskAndGoal(String taskId, [String? goalId]) async {
//     try {
//       isLoadingTaskAndGoal.value = true;
//       final response = await db.getDocument(
//           databaseId: primaryDatabaseId,
//           collectionId: tasksCollectionId,
//           documentId: taskId);
//
//        task.value = null;
//       task.value = Task.fromAppwriteDoc(response);
//       log("TSK task.value updated ${task.value?.totalMinutesSpent}");
//       isCompleted.value = task.value!.isCompleted ?? false;
//
//       if (goalId != null) {
//         final goalResponse = await db.getDocument(
//             databaseId: primaryDatabaseId,
//             collectionId: goalsCollectionId,
//             documentId: goalId);
//         goal.value = Goal.fromAppwriteDoc(goalResponse);
//       }
//     } catch (exception) {
//       log("Error in fetchGoal - $exception");
//     } finally {
//       isLoadingTaskAndGoal.value = false;
//     }
//   }
//
//   // Future<void> updateCompletedStatus(Task task) async {
//   //   try {
//   //     final response = await db.getDocument(
//   //         databaseId: primaryDatabaseId,
//   //         collectionId: tasksCollectionId,
//   //         documentId: task.id);
//   //     final t = Task.fromAppwriteDoc(response);
//
//   //     log("updateCompletedStatus - ${t.isCompleted}");
//   //     isCompleted.value = t.isCompleted ?? false;
//   //   } catch (exception) {
//   //     log("Error in updateCompletedStatus - $exception");
//   //   } finally {}
//   // }
//
//   Future<void> updateTotalTime({required int minutes}) async {
//     try {
//       final alreadySpent = task.value!.totalMinutesSpent ?? 0;
//
//       final tsk = task.value!.copyWith(
//         totalMinutesSpent: alreadySpent + minutes,
//         updatedAt: DateTime.now(),
//         isCompleted: task.value!.isCompleted ?? false,
//       );
//
//       await db.updateDocument(
//         databaseId: primaryDatabaseId,
//         collectionId: tasksCollectionId,
//         documentId: task.value!.id,
//         data: tsk.toMap(),
//       );
//
//       if (goal.value != null) {
//         await db.updateDocument(
//           databaseId: primaryDatabaseId,
//           collectionId: goalsCollectionId,
//           documentId: goal.value!.id,
//           data: goal.value!
//               .copyWith(
//                 totalMinutesSpent:
//                     (goal.value!.totalMinutesSpent ?? 0) + minutes,
//               )
//               .toMap(),
//         );
//       }
//
//       await fetchTaskAndGoal(tsk.id);
//     } catch (exception) {
//       log("TSK Error in updateTotalTime - $exception");
//     } finally {}
//   }
//
//   Future<void> toggleTaskComplete() async {
//     try {
//       isTogglingTaskStatus.value = true;
//
//       log("updateCompletedStatus current value - ${isCompleted.value}");
//
//       await db.updateDocument(
//         databaseId: primaryDatabaseId,
//         collectionId: tasksCollectionId,
//         documentId: task.value!.id,
//         data: task.value!
//             .copyWith(
//               isCompleted: isCompleted.value ? false : true,
//               updatedAt: DateTime.now(),
//             )
//             .toMap(),
//       );
//
//       isCompleted.value = !isCompleted.value;
//     } catch (exception) {
//       // todo show toast
//       // rethrow;
//       // do nothing
//     } finally {
//       isTogglingTaskStatus.value = false;
//     }
//   }
//
// }
