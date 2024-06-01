// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:appwrite/models.dart';

class Goal {
  final String id;
  final String title;
  final String type;
  final String description;
  final String parentGoal;
  final bool isCompleted;
  final int? totalMinutesSpent;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String userId;

  Goal(
      {required this.id,
      required this.title,
      required this.type,
      required this.description,
      required this.parentGoal,
      required this.isCompleted,
      this.totalMinutesSpent,
      this.updatedAt,
      this.createdAt,
      required this.userId});

  Goal copyWith({
    String? id,
    String? title,
    String? type,
    String? description,
    String? parentGoal,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalMinutesSpent,
    String? userId,
  }) {
    return Goal(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        description: description ?? this.description,
        parentGoal: parentGoal ?? this.parentGoal,
        isCompleted: isCompleted ?? this.isCompleted,
        totalMinutesSpent: totalMinutesSpent ?? this.totalMinutesSpent,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userId: userId ?? this.userId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'description': description,
      'parentGoal': parentGoal,
      'isCompleted': isCompleted,
      'totalMinutesSpent': totalMinutesSpent,
      'updatedAt': updatedAt?.toString(),
      'createdAt': createdAt?.toString(),
      'userId': userId
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['\$id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      description: map['description'] as String,
      parentGoal: map['parentGoal'] as String,
      isCompleted: map['isCompleted'] as bool,
      totalMinutesSpent: map['totalMinutesSpent'],
      createdAt:
          map['createdAt'] == null ? null : DateTime.parse(map['createdAt']),
      updatedAt:
          map['updatedAt'] == null ? null : DateTime.parse(map['updatedAt']),
      userId: map['userId'] as String,
    );
  }

  factory Goal.fromAppwriteDoc(Document doc) {
    final data = doc.data;
    return Goal(
      id: doc.$id,
      isCompleted: (data['isCompleted'] ?? false) as bool,
      title: data['title'] as String,
      type: data['type'] as String,
      description: data['description'] as String,
      parentGoal: data['parentGoal'] as String,
      totalMinutesSpent: data['totalMinutesSpent'],
      createdAt:
          data['createdAt'] == null ? null : DateTime.parse(data['createdAt']),
      updatedAt:
          data['updatedAt'] == null ? null : DateTime.parse(data['updatedAt']),
      userId: data['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) =>
      Goal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return title;
  }

  @override
  bool operator ==(covariant Goal other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.type == type &&
        other.description == description &&
        other.parentGoal == parentGoal &&
        other.isCompleted == isCompleted &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        description.hashCode ^
        parentGoal.hashCode ^
        isCompleted.hashCode ^
        userId.hashCode;
  }
}
