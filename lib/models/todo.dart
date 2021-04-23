import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Todo {
  Todo({
    this.uid,
    @required this.title,
    @required this.description,
    @required this.lastModified,
  });

  factory Todo.fromJson(Map<String, Object> json) {
    return Todo(
      uid: json['uid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      lastModified: json['lastModified'] as Timestamp,
    );
  }

  final String uid;
  final String title;
  final String description;
  final Timestamp lastModified;

  Map<String, Object> toJson() {
    return <String, Object>{
      'title': title,
      'description': description,
      'lastModified': lastModified,
    };
  }
}
