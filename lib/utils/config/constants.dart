import 'package:flutter/material.dart';

const String primaryDatabaseId = "TaskRM";
const String tasksCollectionId = "tasks";
const String goalsCollectionId = "goals";

const List<String> timeframes = [
  // "None",
  // "Today",
  // "3 days",
  // "Week",
  // "Fortnight",
  // "Month",
  // "90 Days",
  // "Year"
  "0",
  "1",
  "3",
  "7",
  "14",
  "30",
  "90",
  "365"
];

class AppWriteConstant {
  static const String projectId = "taskrm";
  static const String endPoint = "https://rest.is/v1";
  static const String primaryDBId = "TaskRM";
  static const String userImageBucketId = '65d872347bcd376062c8';
  static const String profileCollectionId = 'user_profile';
  static const String taskCollectionId = 'tasks';
  static const String goalCollectionId = 'goals';
  static const String jiraConnectionCollectionId = 'jiraConnections';



  static const String journalCollectionId = "journal";
  static const String journalImageBucketId = '64ec9cc9d0f052da75d5';
  static const String momentTypeCollectionId = 'moment_type';
  static const String momentEventCollectionId = 'moment_events';
  static const String feedCollectionId = 'feed';
}


// shape: Border(
// bottom: BorderSide(
// color: borderColor,
// width: 1
// )
// ),

// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 5,
// blurRadius: 7,
// offset: Offset(0, 3), // changes position of shadow
// ),
// ],