import 'package:clean_todo/data/models/todo_model.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String? title;
  final bool? completed;

  const TodoEntity({
    required this.id,
    this.title,
    this.completed = false,
  });

  @override
  List<Object?> get props => [id, title, completed];
  
  Map<String, dynamic> toMap() {
    return TodoModel(
      id: id,
      title: title!,
      completed: completed!,
    ).toMap();
  }

  TodoEntity copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
