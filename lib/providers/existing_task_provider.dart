// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';
// import 'package:TaskRM/src/utils/constant.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/material.dart';
// import 'package:TaskRM/src/config/constants.dart';
// import 'package:TaskRM/src/models/task.dart';
// import 'package:intl/intl.dart';
//
// class ExistingTasksProvider with ChangeNotifier {
//
//   final Databases db;
//   ExistingTasksProvider({
//     required this.db,
//   });
//
//   List<Task> _tasks = [];
//   List<Task> visibleTasks = [];
//
//   ValueNotifier<bool> isLoadingTasks = ValueNotifier(true);
//   ValueNotifier<bool> isMarkingTaskForToday = ValueNotifier(false);
//
//   ValueNotifier<Task?> selected = ValueNotifier(null);
//
//   List<String> existingTaskFilters = [];
//   List<String> typeFilters = [];
//   ValueNotifier<String?> selectedTimeframeFilter = ValueNotifier(null);
//   ValueNotifier<String?> selectedTypeFilter = ValueNotifier(null);
//
//   init() {
//     selected.value = null;
//     _tasks = [];
//     visibleTasks = [];
//     isMarkingTaskForToday.value = false;
//     selectedTimeframeFilter.value = null;
//     selectedTypeFilter.value = null;
//     final tfs = timeframes.sublist(2);
//     existingTaskFilters = [...tfs];
//     typeFilters = ['1','2','3'];
//   }
//
//   Future<List<Task>> getTasksFromDb() async {
//     try {
//
//       final uid = await storage.read(key: 'userId');
//
//       isLoadingTasks.value = true;
//       final response = await db.listDocuments(
//           databaseId: primaryDatabaseId,
//           collectionId: tasksCollectionId,
//           queries: [
//             Query.equal("isMarkedForToday", false),
//             Query.equal("isCompleted", false),
//             Query.equal("userID", uid),
//           ]);
//
//       List<Task> models = [];
//
//       for (var t in response.documents) {
//         models.add(Task.fromAppwriteDoc(t));
//       }
//
//       _tasks = models;
//       visibleTasks = [..._tasks];
//       // filterTasks(selectedFilter.value, true);
//       return _tasks;
//     } catch (exception) {
//       log("Error Logged in Appwrite call  - $exception");
//       return [];
//     } finally {
//       isLoadingTasks.value = false;
//     }
//   }
//
//   Future<bool> markTaskForToday() async {
//     try {
//       if (selected.value == null) return false;
//
//       isMarkingTaskForToday.value = true;
//
//       await db.updateDocument(
//         databaseId: primaryDatabaseId,
//         collectionId: tasksCollectionId,
//         documentId: selected.value!.id,
//         data: selected.value!
//             .copyWith(
//               isMarkedForToday: true,
//             )
//             .toMap(),
//       );
//
//       selected.value = null;
//       return true;
//     } catch (exception) {
//       return false;
//     } finally {
//       isMarkingTaskForToday.value = false;
//     }
//   }
//
//   void filterTasks(
//       {String? timeframe, String? type, bool overrideReturn = false}) {
//     if (timeframe != null) {
//       selectedTimeframeFilter.value = timeframe;
//     }
//     if (type != null) {
//       selectedTypeFilter.value = type;
//     }
//     visibleTasks = [];
//
//     if (selectedTimeframeFilter.value != null &&
//         selectedTypeFilter.value != null) {
//       final filtered = _filterBasedOnTimeFrame(selectedTimeframeFilter.value!);
//       final temp = filtered.where((element) {
//         return element.type
//             .toLowerCase()
//             .contains(selectedTypeFilter.value!.toLowerCase());
//       });
//       visibleTasks = [...temp];
//     } else if (selectedTimeframeFilter.value != null) {
//       final temp = _filterBasedOnTimeFrame(selectedTimeframeFilter.value!);
//       visibleTasks = [...temp];
//     } else if (selectedTypeFilter.value != null) {
//       final temp = _tasks.where((element) {
//          return element.type
//             .toLowerCase()
//             .contains(selectedTypeFilter.value!.toLowerCase());
//       });
//       visibleTasks = [...temp];
//     }
//
//     notifyListeners();
//     //   log("Filterrr $tf");
//     //   if (!overrideReturn) {
//     //     if (tf == selectedFilter.value) return;
//     //   }
//     //   selected.value = null;
//     //   selectedFilter.value = tf;
//     //   visibleTasks = [];
//
//     //   if (tf == "All") {
//     //     visibleTasks = [..._tasks];
//     //     log("visibleTasksss $_tasks");
//     //   } else {
//     //     final now = DateTime.now();
//     //     List<Task> tempTasks = [];
//     //     final dr = getDurationFromFilterName(tf);
//     //     log("Filtering dr --> $tf");
//     //     for (Task element in _tasks) {
//     //       if (element.expectedCompletion == null) continue;
//
//     //       var exp = element.expectedCompletion!.subtract(const Duration(days: 1));
//
//     //       if (!now.add(Duration(days: dr)).isBefore(exp)) {
//     //         tempTasks.add(element);
//     //       }
//     //     }
//     //     visibleTasks = [...tempTasks];
//     //   }
//     //   isLoadingTasks.value = true;
//     //   Future.delayed(const Duration(milliseconds: 300), () {
//     //     isLoadingTasks.value = false;
//     //   });
//     // }
//   }
//
//   int getTotalRemainDays(DateTime date) {
//     var localDateTime = date.toLocal();
//     var year = DateFormat('yyyy').format(localDateTime);
//     var month = DateFormat('MM').format(localDateTime);
//     var day = DateFormat('dd').format(localDateTime);
//     var hour = DateFormat('HH').format(localDateTime);
//     var minute = DateFormat('mm').format(localDateTime);
//     var second = DateFormat('ss').format(localDateTime);
//     var classDateTime = DateTime(
//       int.parse(year),
//       int.parse(month),
//       int.parse(day),
//       int.parse(hour),
//       int.parse(minute),
//       int.parse(second),
//     );
//     var currentDate = DateTime.now();
//     var remindSeconds = currentDate.difference(classDateTime).inDays;
//     if (remindSeconds <= 0) {
//       return remindSeconds.abs();
//     } else {
//       return 0;
//     }
//   }
//
//   List<Task> _filterBasedOnTimeFrame(String tf) {
//     final now = DateTime.now();
//     List<Task> tempTasks = [];
//     final dr = getDurationFromFilterName(tf);
//     log("Filtering dr --> $tf");
//     for (Task element in _tasks) {
//
//       // if (element.expectedCompletion == null) continue;
//
//      // var exp = element.expectedCompletion!.subtract(const Duration(days: 1));
//
//       // if (!now.add(Duration(days: dr)).isBefore(exp)) {
//       //   tempTasks.add(element);
//       // }
//
//      // print('element completion date is ${element.expectedCompletion}');
//
//       var totalRemainDays = getTotalRemainDays(element.expectedCompletion!);
//
//       /// previous code //
//       // if(element.timeframe == dr.toString()){
//       //   tempTasks.add(element);
//       // }
//
//       /// 18-9-23 ///
//
//       if(totalRemainDays == dr){
//         tempTasks.add(element);
//       }
//     }
//     return tempTasks;
//   }
//
//   /// previous one ///
//   // int getDurationFromFilterName(String tf) {
//   //   switch (tf.toLowerCase()) {
//   //     /// [not required conditions]
//   //     // case "None":
//   //     //   return null;
//   //     // case "Today":
//   //     //   return const Duration(days: 1);
//   //     case "3 days":
//   //       return 3;
//   //     case "week":
//   //       return 7;
//   //     case "fortnight":
//   //       return 14;
//   //     case "month":
//   //       return 30;
//   //     case "90 days":
//   //       return 90;
//   //     case "year":
//   //       return 365;
//   //     default:
//   //       return 0;
//   //   }
//   // }
//
//   /// built by kafi ///
//   int getDurationFromFilterName(String tf) {
//     switch (tf) {
//       case "3":
//         return 3;
//       case "7":
//         return 7;
//       case "14":
//         return 14;
//       case "30":
//         return 30;
//       case "90":
//         return 90;
//       case "365":
//         return 365;
//       default:
//         return 0;
//     }
//   }
//
// }
