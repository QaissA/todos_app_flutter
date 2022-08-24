part of 'todos_filter_bloc.dart';

abstract class TodosFilterState extends Equatable {
  const TodosFilterState();

  @override
  List<Object> get props => [];
}

class TodosFilterLoadingState extends TodosFilterState {}

class TodosFilterLoadedState extends TodosFilterState {
  final List<Todo> filteredTodos;
  final TodosFilter todosFilter;

  TodosFilterLoadedState({
    required this.filteredTodos,
    this.todosFilter = TodosFilter.all,
  });

  @override
  List<Object> get props => [filteredTodos, todosFilter];
}
