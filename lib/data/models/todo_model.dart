class TodoModel {
  final String id;
  final String title;
  final bool completed;

  TodoModel({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
