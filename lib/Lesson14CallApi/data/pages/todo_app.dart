import 'package:flutter/material.dart';
import 'package:note_app_flutter/Lesson14CallApi/data/pages/todo/todo_list_page.dart';

import '../models/todo_model.dart';
import 'add_todo/add_todo.dart';
import 'add_todo/update_delete_todo.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: TodoPage.routeName,
      routes: {
        TodoPage.routeName: (context) => const TodoPage(),
        AddTodoPage.routeName: (context) => AddTodoPage(
              todo: TodoModel(
                createdAt: DateTime.now(),
                description: '',
                id: '',
                isCompleted: false,
                title: '',
                updatedAt: DateTime.now(),
              ),
            ),
        UDTodoPage.routeName: (context) => UDTodoPage(
              todo: TodoModel(
                createdAt: DateTime.now(),
                description: '',
                id: '',
                isCompleted: false,
                title: '',
                updatedAt: DateTime.now(),
              ),
            ),
      },
    );
  }
}
