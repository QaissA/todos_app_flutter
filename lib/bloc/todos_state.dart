part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadingState extends TodosState {}

class TodosLoadedState extends TodosState {
  final List<Todo> todos;

  const TodosLoadedState({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
