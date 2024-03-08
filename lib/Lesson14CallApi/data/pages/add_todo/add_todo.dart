import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/dio_client.dart';
import '../../models/todo_model.dart';
class AddTodoPage extends StatefulWidget {
  static const routeName = '/add_todo';
  final TodoModel? todo;

  const AddTodoPage({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
        title: const Text('Add Todo'),
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
              await _client.createTodo(
                todoModel: TodoModel(
                  createdAt: DateTime.now(),
                  description: descriptionController.text,
                  id: '',
                  isCompleted: false,
                  title: titleController.text,
                  updatedAt: DateTime.now(),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
