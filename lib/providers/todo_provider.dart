import 'package:asteroid_todo/models/todo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TodosProvider extends ChangeNotifier {
  final CollectionReference _todosDB = FirebaseFirestore.instance.collection('todos');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<Todo> todos = <Todo>[];

  void getAllTodos() {
    _todosDB.orderBy('lastModified', descending: true).snapshots().listen((QuerySnapshot event) {
      // TODO(agustinwalter): You can do it better...
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
      final DocumentReference doc = await _todosDB.add(todo.toJson());
      await _uploadImage(todo, doc.id);
    } else {
      throw AlreadyExistsException('There is already a TODO with this title.');
    }
  }

  /// Edit a todo, throw an [AlreadyExistsException] if a todo with that [title] already exists.
  Future<void> editTodo(Todo todo) async {
    final Todo todoInDB = await searchByTitle(todo.title);
    if (todoInDB == null || todo.uid == todoInDB?.uid) {
      await _todosDB.doc(todo.uid).update(todo.toJson());
      await _uploadImage(todo, todo.uid);
    } else {
      throw AlreadyExistsException('There is already a TODO with this title.');
    }
  }

  /// Delete a todo based on its [uid].
  Future<void> deleteTodo(String uid) async => _todosDB.doc(uid).delete();

  /// Search a todo based on its [title], returns [null] if none is found.
  Future<Todo> searchByTitle(String title) async {
    final QuerySnapshot res = await _todosDB.where('title', isEqualTo: title).get();
    if (res.size == 1) {
      return Todo.fromJson(<String, Object>{
        'uid': res.docs[0].id,
        ...res.docs[0].data(),
      });
    }
    return null;
  }

  Future<void> _uploadImage(Todo todo, String uid) async {
    if (todo.localImage != null) {
      // Upload image
      final UploadTask task = _storage.ref(uid).putFile(todo.localImage);
      await task;
      // Update [imageUrl]
      final String imageUrl = await _storage.ref(uid).getDownloadURL();
      await editTodo(todo.copyWith(uid: uid, imageUrl: imageUrl));
    }
  }
}

class AlreadyExistsException implements Exception {
  AlreadyExistsException(this.message);
  String message;
}
