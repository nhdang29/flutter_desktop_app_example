import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:my_first_desktop_app/model/todo_model.dart';

class TodoController {
  CollectionReference todosCollection = Firestore.instance.collection("todos");

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    final data = await todosCollection.get();
    for (final element in data) {
      final doc = element.map;
      doc["id"] = element.id;
      todos.add(Todo.fromJson(doc));
    }
    return todos;
  }

  Stream<List<Document>> todoStream() {
    return todosCollection.stream;
  }

  Future<void> addTodo (Todo todo) async {
    await todosCollection.add(todo.toJson());
  }

  Future<void> deleteTodo(Todo todo) async {
    await todosCollection.document(todo.id!).delete();
  }

  Future<void> toggleTodo(Todo todo) async {
    await todosCollection.document(todo.id!).update({"complete": !todo.isComplete});
  }

}