// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//import 'package:appwrite/models.dart';

class Goal {
  final String id;
  final String title;
  final String type;
  final String description;
  final int isCompleted;
  final int? totalMinutesSpent;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String userId;
  final String? parentGoal;

  Goal({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.isCompleted,
    this.totalMinutesSpent,
    this.updatedAt,
    this.createdAt,
    required this.userId,
    this.parentGoal
  });

  Goal copyWith({
    String? id,
    String? title,
    String? type,
    String? description,
    int? isCompleted,
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
      isCompleted: isCompleted ?? this.isCompleted,
      totalMinutesSpent: totalMinutesSpent ?? this.totalMinutesSpent,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId ?? this.userId
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'description': description,
      'is_completed': isCompleted,
      'total_minutes_spent': totalMinutesSpent,
      'updated_at': updatedAt?.toString(),
      'created_at': createdAt?.toString(),
      'user_id': userId
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['\$id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      description: map['description'] as String,
      isCompleted: map['is_completed'] as int,
      totalMinutesSpent: map['total_minutes_spent'] as int?,
      createdAt: map['created_at'] == null ? null : DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] == null ? null : DateTime.parse(map['updated_at']),
      userId: map['user_id'] as String,
    );
  }

  // factory Goal.fromAppwriteDoc(Document doc) {
  //   final data = doc.data;
  //   return Goal(
  //     id: doc.$id,
  //     isCompleted: (data['isCompleted'] ?? false) as bool,
  //     title: data['title'] as String,
  //     type: data['type'] as String,
  //     description: data['description'] as String,
  //     totalMinutesSpent: data['totalMinutesSpent'],
  //     createdAt:
  //         data['createdAt'] == null ? null : DateTime.parse(data['createdAt']),
  //     updatedAt:
  //         data['updatedAt'] == null ? null : DateTime.parse(data['updatedAt']),
  //     userId: data['userId'] as String,
  //   );
  // }

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
        other.isCompleted == isCompleted &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        userId.hashCode;
  }
}
