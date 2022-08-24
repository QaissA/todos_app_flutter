import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/Models/todos_filter_model.dart';
import 'package:todos_app/Models/todos_model.dart';
import 'package:todos_app/add_todo_screen.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/bloc/todos_filter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('bloC Pattern : todos'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddToScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
          bottom: TabBar(onTap: (TabIndex){
            switch (TabIndex) {
              case 0:
                BlocProvider.of<TodosFilterBloc>(context).add(UpdateTodos(todosFilter : TodosFilter.pending),),);
                break;
              default:
            }

          },
          tabs: const [
            Tab(icon: Icon(Icons.pending),),
            Tab(icon: Icon(Icons.add_task),),
          ],),
        ),
        body: _todos(),
      ),
    );
  }

  BlocBuilder<TodosBloc, TodosState> _todos() {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TodosLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Pendin To Do :',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _todoCard(context, state.todos[index]);
                    })
              ],
            ),
          );
        } else {
          return const Text("something is wrong !");
        }
      },
    );
  }

  Card _todoCard(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${todo.id} : ' + '${todo.Task}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          UpdateTodos(
                            todo: todo.copyWith(isCompleted: true),
                          ),
                        );
                  },
                  icon: Icon(Icons.add_task),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          DeleteTodos(todo: todo),
                        );
                  },
                  icon: Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
