import 'package:clean_todo/domain/repository/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository _todoRepository;

  DeleteTodoUseCase(this._todoRepository);

  Future<void> call(String id) async {
    return _todoRepository.deleteTodo(id);
  }
}
