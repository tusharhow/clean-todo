import 'package:clean_todo/domain/entities/todo_entity.dart';

abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoEntity todo;

  AddTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  TodoEntity todo;

  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent(this.id);
}
