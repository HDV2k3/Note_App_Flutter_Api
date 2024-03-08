import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/dio_client.dart';
import '../../models/todo_model.dart';

class UDTodoPage extends StatefulWidget {
  static const routeName = '/UD_todo';
  final TodoModel? todo;

  const UDTodoPage({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  State<UDTodoPage> createState() => _UDTodoPageState();
}

class _UDTodoPageState extends State<UDTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController idController = TextEditingController();
  final DioClient _client = DioClient();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      // Access the todo data from widget.todo
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TodoModel? todo =
        ModalRoute.of(context)!.settings.arguments as TodoModel?;
    if (todo != null) {
      titleController.text = todo.title;
      descriptionController.text = todo.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update And Delete Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await _client.updateTodo(
                id: todo!.id.toString(),
                todoModel: TodoModel(
                  createdAt: DateTime.now(),
                  description: descriptionController.text,
                  id: idController.text,
                  isCompleted: false,
                  title: titleController.text,
                  updatedAt: DateTime.now(),
                ),
              );
            },
            child: const Text('Update'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _client.deleteTodo( id: todo!.id.toString());
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
