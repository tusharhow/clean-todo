import 'package:clean_todo/domain/entities/todo_entity.dart';
import 'package:clean_todo/presentation/bloc/todo_bloc.dart';
import 'package:clean_todo/presentation/bloc/todo_event.dart';
import 'package:clean_todo/presentation/bloc/todo_state.dart';
import 'package:clean_todo/presentation/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
                    },
                    child: TodoItem(
                      todo: todo,
                      onDelete: () {
                        context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
                      },
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text('Edit Todo'),
                                  content: TextField(
                                    controller: textController.text.isNotEmpty
                                        ? textController
                                        : TextEditingController(
                                            text: todo.title),
                                    onChanged: (value) {
                                      textController.text = value;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<TodoBloc>().add(
                                              UpdateTodoEvent(TodoEntity(
                                                id: todo.id,
                                                title: textController
                                                        .text.isNotEmpty
                                                    ? textController.text
                                                    : todo.title,
                                                completed: todo.completed,
                                              )),
                                            );
                                        textController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                ));
                      },
                    ));
              },
            );
          } else {
            return const Center(child: Text('No todos found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Add Todo'),
                    content: TextField(
                      controller: textController,
                      onChanged: (value) {
                        textController.text = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<TodoBloc>().add(AddTodoEvent(TodoEntity(
                                id: DateTime.now().toString(),
                                title: textController.text,
                                completed: false,
                              )));
                          textController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
