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

  void addTodo(Todo todo) {
    todosDB
        .add(todo.toJson())
        .then((DocumentReference value) => print('Todo Added'))
        .catchError((dynamic error) => print('Failed to add todo: $error'));
  }

  void editTodo(Todo todo) {
    todosDB
        .doc(todo.uid)
        .update(todo.toJson())
        .then((void value) => print('Todo Updated'))
        .catchError((dynamic error) => print('Failed to update todo: $error'));
  }

  void deleteTodo(String uid) {
    todosDB
        .doc(uid)
        .delete()
        .then((void value) => print('Todo Deleted'))
        .catchError((dynamic error) => print('Failed to delete todo: $error'));
  }
}
