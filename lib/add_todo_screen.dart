import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/Models/todos_model.dart';
import 'package:todos_app/bloc/todos_bloc.dart';

class AddToScreen extends StatelessWidget {
  const AddToScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('BloC Pattern : add To Do'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("To Do Added"),
              ),
            );
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _inputField("ID", controllerId),
                _inputField("Task", controllerTask),
                _inputField("Description", controllerDescription),
                ElevatedButton(
                    onPressed: () {
                      var todo = Todo(
                          id: controllerId.value.text,
                          Task: controllerTask.value.text,
                          Description: controllerDescription.value.text);
                      context.read<TodosBloc>().add(
                            AddTodos(todo: todo),
                          );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: const Text('Add todo'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _inputField(String field, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        )
      ],
    );
  }
}
