import 'package:clean_todo/domain/entities/todo_entity.dart';
 
abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<TodoEntity> todos;

  TodoLoadedState(this.todos);
}

class TodoErrorState extends TodoState {
  final String message;

  TodoErrorState(this.message);
}
