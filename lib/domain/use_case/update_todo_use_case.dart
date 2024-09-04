import 'package:clean_todo/domain/entities/todo_entity.dart';
import 'package:clean_todo/domain/repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository _todoRepository;

  UpdateTodoUseCase(this._todoRepository);

  Future<void> call(TodoEntity todo) async {
    return _todoRepository.updateTodo(todo);
  }
}
