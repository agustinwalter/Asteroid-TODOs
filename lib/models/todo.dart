import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Todo {
  Todo({
    this.uid,
    @required this.title,
    @required this.description,
    @required this.lastModified,
    this.imageUrl,
    this.localImage,
  });

  factory Todo.fromJson(Map<String, Object> json) {
    return Todo(
      uid: json['uid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      lastModified: json['lastModified'] as Timestamp,
    );
  }

  final String uid;
  final String title;
  final String description;
  final String imageUrl;
  final Timestamp lastModified;
  final File localImage;

  Todo copyWith({
    String uid,
    String title,
    String description,
    String imageUrl,
    Timestamp lastModified,
    File localImage,
  }) {
    return Todo(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      lastModified: lastModified ?? this.lastModified,
      // Allows to set [localImage] to null.
      localImage: localImage,
    );
  }

  Map<String, Object> toJson() {
    return <String, Object>{
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'lastModified': lastModified,
    };
  }
}
