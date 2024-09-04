import 'package:clean_todo/domain/entities/todo_entity.dart';
import 'package:clean_todo/domain/repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository _todoRepository;

  AddTodoUseCase(this._todoRepository);

  Future<void> execute(TodoEntity todo) async {
    await _todoRepository.saveTodo(todo);
  }
}
