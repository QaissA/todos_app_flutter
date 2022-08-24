import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/bloc/todos_filter_bloc.dart';
import 'package:todos_app/home_screen.dart';

import 'Models/todos_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
          create: (context) => TodosBloc()
            ..add(
              LoadTodos(todos: [
                Todo(
                    id: '1',
                    Task: "sample To Do #1",
                    Description: 'test number 1'),
                Todo(
                    id: '2',
                    Task: "sample To Do #2",
                    Description: "test number 2"),
              ]),
            ),
        ),
        BlocProvider(
          create: (context) => TodosFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: HomeScreen(),
      ),
    );
  }
}
