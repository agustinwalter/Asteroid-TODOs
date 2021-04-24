import 'package:asteroid_todo/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TodosProvider extends ChangeNotifier {
  CollectionReference todosDB = FirebaseFirestore.instance.collection('todos');
  List<Todo> todos = <Todo>[];

  void getAllTodos() {
    todosDB.orderBy('lastModified', descending: true).snapshots().listen((QuerySnapshot event) {
      todos.clear();
      for (final QueryDocumentSnapshot doc in event.docs) {
        todos.add(Todo.fromJson(<String, Object>{'uid': doc.id, ...doc.data()}));
      }
      notifyListeners();
    });
  }

  /// Add a todo, throw an [AlreadyExistsException] if a todo with that [title] already exists.
  Future<void> addTodo(Todo todo) async {
    final Todo todoInDB = await searchByTitle(todo.title);
    if (todoInDB == null) {
      await todosDB.add(todo.toJson());
    } else {
      throw AlreadyExistsException('There is already a TODO with this title.');
    }
  }

  /// Edit a todo, throw an [AlreadyExistsException] if a todo with that [title] already exists.
  Future<void> editTodo(Todo todo) async {
    final Todo todoInDB = await searchByTitle(todo.title);
    if (todoInDB == null || todo.uid == todoInDB?.uid) {
      await todosDB.doc(todo.uid).update(todo.toJson());
    } else {
      throw AlreadyExistsException('There is already a TODO with this title.');
    }
  }

  /// Delete a todo based on its [uid].
  Future<void> deleteTodo(String uid) async => todosDB.doc(uid).delete();

  /// Search a todo based on its [title], returns [null] if none is found.
  Future<Todo> searchByTitle(String title) async {
    final QuerySnapshot res = await todosDB.where('title', isEqualTo: title).get();
    if (res.size == 1) {
      return Todo.fromJson(<String, Object>{
        'uid': res.docs[0].id,
        ...res.docs[0].data(),
      });
    }
    return null;
  }
}

class AlreadyExistsException implements Exception {
  AlreadyExistsException(this.message);
  String message;
}
