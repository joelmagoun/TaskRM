import 'package:powersync/sqlite3_common.dart' as sqlite;
import '../powersync.dart';

// class Task {
//   final String id;
//   final String title;
//   final String type;
//   final String priority;
//   final String timeframe;
//   final String description;
//   final DateTime createdAt;
//   final DateTime? expectedCompletion;
//   final String? goalId;
//   final bool isMarkedForToday;
//   final bool? isCompleted;
//   final DateTime? updatedAt;
//   final int? totalMinutesSpent;
//   final String jiraID;
//   final String userID;
//   final String goal;
//
//   Task({
//     required this.id,
//     required this.title,
//     required this.type,
//     required this.priority,
//     required this.timeframe,
//     required this.description,
//     required this.createdAt,
//     required this.expectedCompletion,
//     this.goalId,
//     required this.isMarkedForToday,
//     this.isCompleted,
//     this.updatedAt,
//     this.totalMinutesSpent,
//     required this.jiraID,
//     required this.userID,
//     required this.goal,
//   });
//
//   String get getTaskPriorityString => priority.replaceAll("_", " ");
//
//   String get getTaskTypeString => type.replaceAll("_", " ");
//
//   Task copyWith({
//     String? id,
//     String? title,
//     String? type,
//     String? priority,
//     String? timeframe,
//     String? description,
//     DateTime? createdAt,
//     DateTime? expectedCompletion,
//     String? goalId,
//     bool? isMarkedForToday,
//     bool? isCompleted,
//     int? totalMinutesSpent,
//     DateTime? updatedAt,
//     String? jiraID,
//     String? userID,
//     String? goal,
//   }) {
//     return Task(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         type: type ?? this.type,
//         priority: priority ?? this.priority,
//         timeframe: timeframe ?? this.timeframe,
//         description: description ?? this.description,
//         createdAt: createdAt ?? this.createdAt,
//         expectedCompletion: expectedCompletion ?? this.expectedCompletion,
//         goalId: goalId ?? this.goalId,
//         isMarkedForToday: isMarkedForToday ?? this.isMarkedForToday,
//         isCompleted: isCompleted ?? this.isCompleted,
//         updatedAt: updatedAt ?? this.updatedAt,
//         totalMinutesSpent: totalMinutesSpent ?? this.totalMinutesSpent,
//         jiraID: jiraID ?? this.jiraID,
//         userID: userID ?? this.userID,
//         goal: goal ?? this.goal);
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'title': title,
//       'type': type,
//       'priority': priority,
//       'timeframe': timeframe,
//       'description': description,
//       'createdAt': createdAt.toString(),
//       'updatedAt': updatedAt.toString(),
//       'expectedCompletion': expectedCompletion?.toString(),
//       'goalId': goalId,
//       'isMarkedForToday': isMarkedForToday,
//       'isCompleted': isCompleted,
//       'totalMinutesSpent': totalMinutesSpent,
//       'jiraID': jiraID,
//       'userID': userID,
//       'goal': goal
//     };
//   }
//
//   // factory Task.fromAppwriteDoc(Document doc) {
//   //   final data = doc.data;
//   //   log("TSK $data");
//   //   return Task(
//   //       id: doc.$id,
//   //       title: data['title'] as String,
//   //       type: data['type'] as String,
//   //       priority: data['priority'] as String,
//   //       timeframe: data['timeframe'] as String,
//   //       description: data['description'] as String,
//   //       createdAt: DateTime.parse(data['createdAt']),
//   //       expectedCompletion: data['expectedCompletion'] != null
//   //           ? DateTime.parse(data['expectedCompletion'])
//   //           : null,
//   //       goalId: data['goalId'] as String?,
//   //       isMarkedForToday: data['isMarkedForToday'] as bool,
//   //       totalMinutesSpent: data['totalMinutesSpent'],
//   //       updatedAt: data['updatedAt'] == null
//   //           ? DateTime.parse(data['createdAt'])
//   //           : DateTime.parse(data['updatedAt']),
//   //       isCompleted:
//   //           data['isCompleted'] == null ? null : data['isCompleted'] as bool,
//   //       jiraID: data['jiraID'] as String,
//   //       userID: data['userID'] as String,
//   //       goal: data['goal'] as String);
//   // }
//
//   @override
//   String toString() {
//     return 'Task(id: $id, title: $title, type: $type, priority: $priority, timeframe: $timeframe, description: $description, createdAt: $createdAt, expectedCompletion: $expectedCompletion, goalId: $goalId, isMarkedForToday: $isMarkedForToday, jiraID: $jiraID, userID: $userID, goal: $goal)';
//   }
//
//   @override
//   bool operator ==(covariant Task other) {
//     if (identical(this, other)) return true;
//
//     return other.id == id &&
//         other.title == title &&
//         other.type == type &&
//         other.priority == priority &&
//         other.timeframe == timeframe &&
//         other.description == description &&
//         other.createdAt == createdAt &&
//         other.expectedCompletion == expectedCompletion &&
//         other.goalId == goalId &&
//         other.isMarkedForToday == isMarkedForToday &&
//         other.jiraID == jiraID &&
//         other.userID == userID &&
//         other.goal == goal;
//   }
//
//   @override
//   int get hashCode {
//     return id.hashCode ^
//         title.hashCode ^
//         type.hashCode ^
//         priority.hashCode ^
//         timeframe.hashCode ^
//         description.hashCode ^
//         createdAt.hashCode ^
//         expectedCompletion.hashCode ^
//         goalId.hashCode ^
//         isMarkedForToday.hashCode ^
//         jiraID.hashCode ^
//         userID.hashCode ^
//         goal.hashCode;
//   }
//
//   /// previous code ///
//   // DateTime? get getExpectedDateFromTimeframe {
//   //
//   //   final now = DateTime.now();
//   //
//   //   switch (timeframe.toLowerCase()) {
//   //     case "none":
//   //       return null;
//   //     case "today":
//   //       return now.add(const Duration(days: 1));
//   //     case "3 days":
//   //       return now.add(const Duration(days: 3));
//   //     case "week":
//   //       return now.add(const Duration(days: 7));
//   //     case "fortnight":
//   //       return now.add(const Duration(days: 14));
//   //     case "month":
//   //       return now.add(const Duration(days: 30));
//   //     case "90 days":
//   //       return now.add(const Duration(days: 90));
//   //     case "year":
//   //       return now.add(const Duration(days: 365));
//   //     default:
//   //       return null;
//   //   }
//   // }
//
//   /// new code from kafi ///
//
//   DateTime? get getExpectedDateFromTimeframe {
//     final now = DateTime.now();
//
//     switch (timeframe.toLowerCase()) {
//       case "0":
//         return null;
//       case "1":
//         return now.add(const Duration(days: 1));
//       case "3":
//         return now.add(const Duration(days: 3));
//       case "7":
//         return now.add(const Duration(days: 7));
//       case "14":
//         return now.add(const Duration(days: 14));
//       case "30":
//         return now.add(const Duration(days: 30));
//       case "90":
//         return now.add(const Duration(days: 90));
//       case "365":
//         return now.add(const Duration(days: 365));
//       default:
//         return null;
//     }
//   }
//
//   factory Task.fromMap(Map<String, dynamic> map) {
//     return Task(
//         id: map['id'] as String,
//         title: map['title'] as String,
//         type: map['type'] as String,
//         priority: map['priority'] as String,
//         timeframe: map['timeframe'] as String,
//         description: map['description'] as String,
//         totalMinutesSpent: map['totalMinutesSpent'] as int,
//         createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
//         updatedAt: map['updatedAt'] == null
//             ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
//             : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
//         expectedCompletion: map['expectedCompletion'] != null
//             ? DateTime.fromMillisecondsSinceEpoch(
//                 map['expectedCompletion'] as int)
//             : null,
//         goalId: map['goalId'] != null ? map['goalId'] as String : null,
//         isMarkedForToday: map['isMarkedForToday'] as bool,
//         jiraID: map['jiraID'] as String,
//         userID: map['userID'] as String,
//         goal: map['goal'] as String);
//   }
//
//   factory Task.fromJson(String source) =>
//       Task.fromMap(json.decode(source) as Map<String, dynamic>);
// }

class TaskModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? timeframe;
  String? jiraId;
  String? title;
  String? type;
  int? isMarkedForToday;
  String? goalId;
  String? priority;
  String? description;
  String? userId;
  String? goal;
  String? expectedCompletion;
  int? isCompleted;
  int? totalMinutesSpent;

  TaskModel(
      {  this.id,
        this.createdAt,
        this.updatedAt,
        this.timeframe,
        this.jiraId,
        this.title,
        this.type,
        this.isMarkedForToday,
        this.goalId,
        this.priority,
        this.description,
        this.userId,
        this.goal,
        this.expectedCompletion,
        this.isCompleted,
        this.totalMinutesSpent});

  /// for powersync ///

  TaskModel.fromMap({
    required Map<String, dynamic> map,
    required String myUserId,
  })  : id = map['id'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        timeframe = map['timeframe'],
        jiraId = map['jira_id'],
        title = map['title'],
        type = map['type'],
        isMarkedForToday = map['is_marked_for_today'],
        goalId = map['goal_id'],
        priority = map['priority'],
        description = map['description'],
        userId = map['user_id'],
        goal = map['goal'],
        expectedCompletion = map['expected_completion'],
        isCompleted = map['is_completed'],
        totalMinutesSpent = map['total_minutes_spent'];

  factory TaskModel.fromRow(sqlite.Row row, String myUserId) {
    return TaskModel(
        id: row['id'],
        createdAt: row['created_at'],
        updatedAt: row['updated_at'],
        timeframe: row['timeframe'],
        jiraId: row['jira_id'],
        title: row['title'],
        type: row['type'],
        isMarkedForToday: row['is_marked_for_today'],
        goalId: row['goal_id'],
        priority: row['priority'],
        description: row['description'],
        userId: row['user_id'],
        goal: row['goal'],
        expectedCompletion: row['expected_completion'],
        isCompleted: row['is_completed'],
        totalMinutesSpent: row['total_minutes_spent']);
  }

  // static Stream<List<TaskModel>> watchMessages(String myUserId) {
  //   var response = db
  //       .watch('SELECT * FROM tasks ORDER BY created_at DESC')
  //       .map((results) {
  //     return results
  //         .map((row) => TaskModel.fromRow(row, myUserId))
  //         .toList(growable: false);
  //   });
  //   print('response in watch $response');
  //   return response;
  // }

  // static Future<void> create(
  //   String title,
  //   String type,
  //   String goalId,
  //   String priority,
  //   String timeFrame,
  //   String description,
  //   String uid,
  //   String goal,
  //   String expectedDate,
  // ) async {
  //   await db.execute(
  //       'INSERT INTO tasks(created_at, updated_at, timeframe, jira_id, title, type, is_marked_for_today, goal_id, priority, description, user_id, goal, expected_completion, is_completed, total_minutes_spent) VALUES(uuid(), datetime(), ?, ?)',
  //       [
  //         DateTime.now().toIso8601String(),
  //         DateTime.now().toIso8601String(),
  //         timeFrame,
  //         '',
  //         title,
  //         type,
  //         timeFrame == 'Today' ? 1 : 0,
  //         goalId,
  //         priority,
  //         description,
  //         uid,
  //         goal,
  //         expectedDate,
  //         0,
  //         0
  //       ]);
  // }

  /// for powersync ///

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    timeframe = json['timeframe'];
    jiraId = json['jira_id'];
    title = json['title'];
    type = json['type'];
    isMarkedForToday = json['is_marked_for_today'];
    goalId = json['goal_id'];
    priority = json['priority'];
    description = json['description'];
    userId = json['user_id'];
    goal = json['goal'];
    expectedCompletion = json['expected_completion'];
    isCompleted = json['is_completed'];
    totalMinutesSpent = json['total_minutes_spent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['timeframe'] = this.timeframe;
    data['jira_id'] = this.jiraId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['is_marked_for_today'] = this.isMarkedForToday;
    data['goal_id'] = this.goalId;
    data['priority'] = this.priority;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['goal'] = this.goal;
    data['expected_completion'] = this.expectedCompletion;
    data['is_completed'] = this.isCompleted;
    data['total_minutes_spent'] = this.totalMinutesSpent;
    return data;
  }
}
