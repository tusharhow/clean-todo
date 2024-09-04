import 'package:clean_todo/domain/use_case/add_todo_use_case.dart';
import 'package:clean_todo/domain/use_case/delete_todo_use_case.dart';
import 'package:clean_todo/domain/use_case/get_todos_use_case.dart';
import 'package:clean_todo/domain/use_case/update_todo_use_case.dart';
import 'package:clean_todo/presentation/bloc/todo_event.dart';
import 'package:clean_todo/presentation/bloc/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoBloc({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitialState()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(
      LoadTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      final todos = await getTodosUseCase.execute();
      emit(TodoLoadedState(todos));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await addTodoUseCase.execute(event.todo);
      add(LoadTodosEvent());
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      await updateTodoUseCase.call(event.todo);
      add(LoadTodosEvent());
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await deleteTodoUseCase.call(event.id);
      add(LoadTodosEvent());
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }
}
