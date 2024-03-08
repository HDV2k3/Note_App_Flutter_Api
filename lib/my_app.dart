import 'package:flutter/material.dart';

import 'Lesson14CallApi/data/models/todo_model.dart';
import 'Lesson14CallApi/data/pages/add_todo/add_todo.dart';
import 'Lesson14CallApi/data/pages/add_todo/update_delete_todo.dart';
import 'Lesson14CallApi/data/pages/todo/todo_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: TodoPage.routeName,
      routes: {
        TodoPage.routeName: (context) => const TodoPage(),
        AddTodoPage.routeName:(context) => AddTodoPage(todo: TodoModel(
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