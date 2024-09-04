import 'package:clean_todo/data/data_sources/local_data_source.dart';
import 'package:clean_todo/data/repositories/todo_repository_impl.dart';
import 'package:clean_todo/domain/use_case/add_todo_use_case.dart';
import 'package:clean_todo/domain/use_case/delete_todo_use_case.dart';
import 'package:clean_todo/domain/use_case/get_todos_use_case.dart';
import 'package:clean_todo/domain/use_case/update_todo_use_case.dart';
import 'package:clean_todo/presentation/bloc/todo_bloc.dart';
import 'package:clean_todo/presentation/bloc/todo_event.dart';
import 'package:clean_todo/presentation/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final localDataSource = LocalDataSource(sharedPreferences: sharedPreferences);
  final todoRepository = TodoRepositoryImpl(localDataSource: localDataSource);

  final getTodosUseCase = GetTodosUseCase(todoRepository);
  final addTodoUseCase = AddTodoUseCase(todoRepository);
  final updateTodoUseCase = UpdateTodoUseCase(todoRepository);
  final deleteTodoUseCase = DeleteTodoUseCase(todoRepository);

  runApp(MyApp(
    getTodosUseCase: getTodosUseCase,
    addTodoUseCase: addTodoUseCase,
    updateTodoUseCase: updateTodoUseCase,
    deleteTodoUseCase: deleteTodoUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetTodosUseCase getTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  const MyApp({
    super.key,
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodoBloc(
            getTodosUseCase: getTodosUseCase,
            addTodoUseCase: addTodoUseCase,
            updateTodoUseCase: updateTodoUseCase,
            deleteTodoUseCase: deleteTodoUseCase,
          )..add(LoadTodosEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Clean Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoScreen(),
      ),
    );
  }
}
