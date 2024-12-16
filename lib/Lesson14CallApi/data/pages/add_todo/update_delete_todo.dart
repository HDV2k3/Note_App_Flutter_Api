import 'package:flutter/material.dart';
import 'package:note_app_flutter/Lesson14CallApi/data/pages/todo/todo_list_page.dart';

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
      titleController.text = widget.todo!.title!;
      descriptionController.text = widget.todo!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TodoModel? todo =
        ModalRoute.of(context)!.settings.arguments as TodoModel?;
    if (todo != null) {
      titleController.text = todo.title!;
      descriptionController.text = todo.description!;
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
              if (titleController.text.isEmpty ||
                  descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              final updatedTodo = await _client.updateTodo(
                id: todo!.id.toString(),
                todoModel: TodoModel(
                  createdAt: todo.createdAt,
                  description: descriptionController.text,
                  id: todo.id,
                  isCompleted: todo.isCompleted,
                  title: titleController.text,
                  updatedAt: DateTime.now(),
                ),
              );

              if (updatedTodo != null) {
                // Navigator.pop(
                //     context, {'action': 'update', 'todo': updatedTodo});
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TodoPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cập nhập  thành công'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to update Todo')),
                );
              }
            },
            child: const Text('Update'),
          ),
          ElevatedButton(
            onPressed: () async {
              final isDeleted =
                  await _client.deleteTodo(id: todo!.id.toString());

              if (isDeleted != null) {
                // Trả về dữ liệu đúng sau khi xóa
                // Navigator.pop(context, {'action': 'delete', 'id': todo.id});
                // Đăng nhập thành công, chuyển trang
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TodoPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Xóa thành công'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to delete Todo')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
