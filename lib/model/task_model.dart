import 'package:flutter/material.dart';

class TaskModel {
  List<TaskData>? data;

  TaskModel({this.data});

  TaskModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => TaskData.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (data != null) {
      json["data"] = data?.map((e) => e.toJson()).toList();
    }
    return json;
  }
}

class TaskData {
  String? title;
  String? priority;
  String? description;
  late String? endDate;
  int? priorityLevel;

  Color get priorityColor {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  TaskData({
    this.title,
    this.priority,
    this.description,
    this.endDate,
    this.priorityLevel,
  });

  TaskData.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["priority"] is String) {
      priority = json["priority"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["endDate"] is String) {
      endDate = json["endDate"];
    }
    if (json["priority_level"] is int) {
      priorityLevel = json["priority_level"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["title"] = title;
    json["priority"] = priority;
    json["description"] = description;
    json["endDate"] = endDate;
    json["priority_level"] = priorityLevel;
    return json;
  }
}
