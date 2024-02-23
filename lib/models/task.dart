// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/models.dart';

class Task {
  final String id;
  final String title;
  final String type;
  final String priority;
  final String timeframe;
  final String description;
  final DateTime createdAt;
  final DateTime? expectedCompletion;
  final String? goalId;
  final bool isMarkedForToday;
  final bool? isCompleted;
  final DateTime? updatedAt;
  final int? totalMinutesSpent;
  final String jiraID;
  final String userID;

  Task({
    required this.id,
    required this.title,
    required this.type,
    required this.priority,
    required this.timeframe,
    required this.description,
    required this.createdAt,
    required this.expectedCompletion,
    this.goalId,
    required this.isMarkedForToday,
    this.isCompleted,
    this.updatedAt,
    this.totalMinutesSpent,
    required this.jiraID,
    required this.userID,
  });

  String get getTaskPriorityString => priority.replaceAll("_", " ");

  String get getTaskTypeString => type.replaceAll("_", " ");

  Task copyWith({
    String? id,
    String? title,
    String? type,
    String? priority,
    String? timeframe,
    String? description,
    DateTime? createdAt,
    DateTime? expectedCompletion,
    String? goalId,
    bool? isMarkedForToday,
    bool? isCompleted,
    int? totalMinutesSpent,
    DateTime? updatedAt,
    String? jiraID,
    String? userID,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      timeframe: timeframe ?? this.timeframe,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      expectedCompletion: expectedCompletion ?? this.expectedCompletion,
      goalId: goalId ?? this.goalId,
      isMarkedForToday: isMarkedForToday ?? this.isMarkedForToday,
      isCompleted: isCompleted ?? this.isCompleted,
      updatedAt: updatedAt ?? this.updatedAt,
      totalMinutesSpent: totalMinutesSpent ?? this.totalMinutesSpent,
      jiraID: jiraID ?? this.jiraID,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'priority': priority,
      'timeframe': timeframe,
      'description': description,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'expectedCompletion': expectedCompletion?.toString(),
      'goalId': goalId,
      'isMarkedForToday': isMarkedForToday,
      'isCompleted': isCompleted,
      'totalMinutesSpent': totalMinutesSpent,
      'jiraID': jiraID,
      'userID': userID
    };
  }

  factory Task.fromAppwriteDoc(Document doc) {
    final data = doc.data;
    log("TSK $data");
    return Task(
        id: doc.$id,
        title: data['title'] as String,
        type: data['type'] as String,
        priority: data['priority'] as String,
        timeframe: data['timeframe'] as String,
        description: data['description'] as String,
        createdAt: DateTime.parse(data['createdAt']),
        expectedCompletion: data['expectedCompletion'] != null
            ? DateTime.parse(data['expectedCompletion'])
            : null,
        goalId: data['goalId'] as String?,
        isMarkedForToday: data['isMarkedForToday'] as bool,
        totalMinutesSpent: data['totalMinutesSpent'],
        updatedAt: data['updatedAt'] == null
            ? DateTime.parse(data['createdAt'])
            : DateTime.parse(data['updatedAt']),
        isCompleted:
            data['isCompleted'] == null ? null : data['isCompleted'] as bool,
        jiraID: data['jiraID'] as String,
        userID: data['userID'] as String);
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, type: $type, priority: $priority, timeframe: $timeframe, description: $description, createdAt: $createdAt, expectedCompletion: $expectedCompletion, goalId: $goalId, isMarkedForToday: $isMarkedForToday, jiraID: $jiraID, userID: $userID)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.type == type &&
        other.priority == priority &&
        other.timeframe == timeframe &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.expectedCompletion == expectedCompletion &&
        other.goalId == goalId &&
        other.isMarkedForToday == isMarkedForToday &&
        other.jiraID == jiraID &&
        other.userID == userID;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        priority.hashCode ^
        timeframe.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        expectedCompletion.hashCode ^
        goalId.hashCode ^
        isMarkedForToday.hashCode ^
        jiraID.hashCode ^
        userID.hashCode;
  }

  /// previous code ///
  // DateTime? get getExpectedDateFromTimeframe {
  //
  //   final now = DateTime.now();
  //
  //   switch (timeframe.toLowerCase()) {
  //     case "none":
  //       return null;
  //     case "today":
  //       return now.add(const Duration(days: 1));
  //     case "3 days":
  //       return now.add(const Duration(days: 3));
  //     case "week":
  //       return now.add(const Duration(days: 7));
  //     case "fortnight":
  //       return now.add(const Duration(days: 14));
  //     case "month":
  //       return now.add(const Duration(days: 30));
  //     case "90 days":
  //       return now.add(const Duration(days: 90));
  //     case "year":
  //       return now.add(const Duration(days: 365));
  //     default:
  //       return null;
  //   }
  // }

  /// new code from kafi ///

  DateTime? get getExpectedDateFromTimeframe {
    final now = DateTime.now();

    switch (timeframe.toLowerCase()) {
      case "0":
        return null;
      case "1":
        return now.add(const Duration(days: 1));
      case "3":
        return now.add(const Duration(days: 3));
      case "7":
        return now.add(const Duration(days: 7));
      case "14":
        return now.add(const Duration(days: 14));
      case "30":
        return now.add(const Duration(days: 30));
      case "90":
        return now.add(const Duration(days: 90));
      case "365":
        return now.add(const Duration(days: 365));
      default:
        return null;
    }
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      priority: map['priority'] as String,
      timeframe: map['timeframe'] as String,
      description: map['description'] as String,
      totalMinutesSpent: map['totalMinutesSpent'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] == null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      expectedCompletion: map['expectedCompletion'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['expectedCompletion'] as int)
          : null,
      goalId: map['goalId'] != null ? map['goalId'] as String : null,
      isMarkedForToday: map['isMarkedForToday'] as bool,
      jiraID: map['jiraID'] as String,
      userID: map['userID'] as String
    );
  }

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

}
