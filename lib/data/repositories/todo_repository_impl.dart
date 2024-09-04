import 'package:clean_todo/data/data_sources/local_data_source.dart';
import 'package:clean_todo/data/models/todo_model.dart';
import 'package:clean_todo/domain/entities/todo_entity.dart';
import 'package:clean_todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final LocalDataSource localDataSource;
  TodoRepositoryImpl({required this.localDataSource});
  @override
  Future<void> clearTodos() {
    return localDataSource.clearTodos();
  }

  @override
  Future<void> deleteTodo(String id) {
    return localDataSource.deleteTodo(id);
  }

  @override
  Future<List<TodoEntity>> getTodos() async {
    final todos = await localDataSource.getTodos();
    return todos
        .map((model) => TodoEntity(
              id: model.id,
              title: model.title,
              completed: model.completed,
            ))
        .toList();
  }

  @override
  Future<void> saveTodo(TodoEntity todo) {
    final addTodo = TodoEntity(
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
    return localDataSource.saveTodo(TodoModel(
      id: addTodo.id,
      title: addTodo.title!,
      completed: addTodo.completed!,
    ));
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    return localDataSource.updateTodo(TodoModel(
      id: todo.id,
      title: todo.title!,
      completed: todo.completed!,
    ));
  }
}
