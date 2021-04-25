import 'package:asteroid_todo/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Timestamp someTime;

  setUp(() => someTime = Timestamp.now());

  test('[Todo] model - [fromJson] constructor must work.', () {
    final Map<String, Object> todoJson = <String, Object>{
      'uid': 'some-uid',
      'title': 'some-title',
      'description': 'some-description',
      'imageUrl': 'some-imageUrl',
      'lastModified': someTime
    };

    final Todo todo = Todo.fromJson(todoJson);

    expect(todo.uid, 'some-uid');
    expect(todo.title, 'some-title');
    expect(todo.description, 'some-description');
    expect(todo.imageUrl, 'some-imageUrl');
    expect(todo.lastModified, someTime);
  });

  test('[Todo] model - [copyWith] method must work.', () {
    final Todo todo = Todo(
      uid: 'some-uid',
      title: 'some-title',
      description: 'some-description',
      imageUrl: 'some-imageUrl',
      lastModified: Timestamp.now(),
    );

    final Todo todoModified = todo.copyWith(
      uid: 'some-uid-modified',
      title: 'some-title-modified',
      description: 'some-description-modified',
      imageUrl: 'some-imageUrl-modified',
      lastModified: someTime,
    );

    expect(todoModified.uid, 'some-uid-modified');
    expect(todoModified.title, 'some-title-modified');
    expect(todoModified.description, 'some-description-modified');
    expect(todoModified.imageUrl, 'some-imageUrl-modified');
    expect(todoModified.lastModified, someTime);
  });

  test('[Todo] model - [toJson] method must work.', () {
    final Todo todo = Todo(
      uid: 'some-uid',
      title: 'some-title',
      description: 'some-description',
      imageUrl: 'some-imageUrl',
      lastModified: someTime,
    );

    final Map<String, Object> todoJson = todo.toJson();

    expect(todoJson['title'], 'some-title');
    expect(todoJson['description'], 'some-description');
    expect(todoJson['imageUrl'], 'some-imageUrl');
    expect(todoJson['lastModified'], someTime);
  });
}
