import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String Task;
  final String Description;
  bool? isCompleted;
  bool? isCanceled;

  Todo(
      {required this.id,
      required this.Task,
      required this.Description,
      this.isCompleted,
      this.isCanceled}) {
    isCanceled = isCanceled ?? false;
    isCompleted = isCompleted ?? false;
  }

  Todo copyWith({
    String? id,
    String? Task,
    String? Description,
    bool? isCompleted,
    bool? isCanceled,
  }) {
    return Todo(
        id: id ?? this.id,
        Task: Task ?? this.Task,
        Description: Description ?? this.Description,
        isCompleted: isCompleted ?? this.isCompleted,
        isCanceled: isCanceled ?? this.isCanceled);
  }

  @override
  List<Object?> get props => [id, Task, Description, isCompleted, isCanceled];

  static List<Todo> todos = [
    Todo(id: '1', Task: "sample To Do #1", Description: 'test number 1'),
    Todo(id: '2', Task: "sample To Do #2", Description: "test number 2"),
  ];
}
