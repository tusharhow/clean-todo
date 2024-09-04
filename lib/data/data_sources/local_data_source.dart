import 'dart:convert';

import 'package:clean_todo/data/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSource({required this.sharedPreferences});

  Future<List<TodoModel>> getTodos() async {
    final todos = sharedPreferences.getStringList('todos');
    if (todos == null) {
      return [];
    }
    return todos
        .map((json) =>
            TodoModel.fromMap(Map<String, dynamic>.from(jsonDecode(json))))
        .toList();
  }

  Future<void> saveTodo(TodoModel todo) async {
    final List<TodoModel> currentTodos = await getTodos();
    currentTodos.add(todo);
    await sharedPreferences.setStringList(
        'todos', currentTodos.map((todo) => jsonEncode(todo.toMap())).toList());
  }

  Future<void> clearTodos() async {
    await sharedPreferences.remove('todos');
  }

  Future<void> updateTodo(TodoModel todo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await sharedPreferences.setStringList(
          'todos', todos.map((todo) => jsonEncode(todo.toMap())).toList());
    }
  }

  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    final index = todos.indexWhere((element) => element.id == id);
    if (index != -1) {
      todos.removeAt(index);
      await sharedPreferences.setStringList(
          'todos', todos.map((todo) => jsonEncode(todo.toMap())).toList());
    }
  }
}
