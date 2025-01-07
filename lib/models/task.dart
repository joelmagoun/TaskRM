import 'package:powersync/sqlite3_common.dart' as sqlite;
import '../powersync.dart';

class Task {
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

  Task({
    this.id,
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
    this.totalMinutesSpent,
  });

  Task.fromJson(Map<String, dynamic> json) {
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
