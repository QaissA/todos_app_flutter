import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/Models/todos_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoadingState()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodos>(_onAddTodos);
    on<UpdateTodos>(_onUpdateTodos);
    on<DeleteTodos>(_onDeleteTodos);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    emit(TodosLoadedState(todos: event.todos));
  }

  void _onAddTodos(AddTodos event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoadedState) {
      emit(
        TodosLoadedState(
          todos: List.from(state.todos)..add(event.todo),
        ),
      );
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoadedState) {
      List<Todo> todos = (state.todos.map(
        (todo) {
          return todo.id == event.todo.id ? event.todo : todo;
        },
      )).toList();

      emit(TodosLoadedState(todos: todos));
    }
  }

  void _onDeleteTodos(DeleteTodos event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoadedState) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();
      emit(
        TodosLoadedState(todos: todos),
      );
    }
  }
}
