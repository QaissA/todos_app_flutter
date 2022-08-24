import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/bloc/todos_bloc.dart';

import '../Models/todos_filter_model.dart';
import '../Models/todos_model.dart';

part 'todos_filter_event.dart';
part 'todos_filter_state.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosFilterBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosFilterLoadingState()) {
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateTodos>(_onUpdateTodos);

    _todosSubscription = todosBloc.stream.listen((state) {
      add(
        const UpdateTodos(),
      );
    });
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<TodosFilterState> emit) {
    if (state is TodosFilterLoadingState) {
      add(
        const UpdateTodos(todosFilter: TodosFilter.pending),
      );
      if (state is TodosFilterLoadedState) {
        final state = this.state as TodosFilterLoadedState;
        add(
          UpdateTodos(todosFilter: state.todosFilter),
        );
      }
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosFilterState> emit) {
    final state = _todosBloc.state;

    if (state is TodosLoadedState) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.todosFilter) {
          case TodosFilter.all:
            return true;
          case TodosFilter.completed:
            return todo.isCompleted!;
          case TodosFilter.cancelled:
            return todo.isCanceled!;
          case TodosFilter.pending:
            return !(todo.isCanceled! || todo.isCompleted!);
        }
      }).toList();
    }
  }
}
