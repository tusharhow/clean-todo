import 'package:clean_todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<void> saveTodo(TodoEntity todos);
  Future<void> clearTodos();
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(String id);
}
