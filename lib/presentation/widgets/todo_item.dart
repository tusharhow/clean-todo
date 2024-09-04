import 'package:clean_todo/domain/entities/todo_entity.dart';
import 'package:flutter/material.dart';
 
class TodoItem extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onDelete;
  final VoidCallback onClick;

  const TodoItem({super.key, 
    required this.todo,
    required this.onDelete,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onClick,
        title: Text(todo.title!),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
