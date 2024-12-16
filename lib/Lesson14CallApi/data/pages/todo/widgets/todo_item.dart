import 'package:flutter/material.dart';

import '../../../models/todo_model.dart';
import '../../add_todo/update_delete_todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.todo,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final TodoModel todo;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          final updatedTodo = await Navigator.pushNamed(
            context,
            UDTodoPage.routeName,
            arguments: todo,
          ) as TodoModel?;

          if (updatedTodo != null) {}
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                todo.title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(todo.description!),
            ],
          ),
        ),
      ),
    );
  }
}
