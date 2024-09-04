import 'package:clean_todo/domain/entities/todo_entity.dart';
import 'package:clean_todo/domain/repository/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository _todoRepository;

  GetTodosUseCase(this._todoRepository);

  Future<List<TodoEntity>> execute() async {
    return await _todoRepository.getTodos();
  }
}
