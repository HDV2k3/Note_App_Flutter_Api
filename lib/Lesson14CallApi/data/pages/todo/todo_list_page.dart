
import 'package:flutter/material.dart';
import '../../api/dio_client.dart';
import '../../models/responses/todo_responses.dart';
import '../../models/todo_model.dart';
import '../add_todo/add_todo.dart';
import '../add_todo/update_delete_todo.dart';
import 'widgets/todo_item.dart';
// import 'package:http/http.dart' as http;
class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);
  static const routeName = '/todo';
  @override
  State<TodoPage> createState() => _TodoPageState();
}
class _TodoPageState extends State<TodoPage> {
  List<TodoModel> todos = [];
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),

      body: SafeArea(
        child: FutureBuilder<TodoResponse?>(
          future: _client.getTodos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final todoResponse = snapshot.data;
              final todoModels = todoResponse?.todos ?? [];  // assuming the todos are directly in the response
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return TodoItem(
                    todo: todoModels[index],
                    onTap: () async {
                      final todo = await Navigator.pushNamed(
                        context,
                        UDTodoPage.routeName,
                        arguments: todoModels[index],
                      ) as TodoModel?;
                      if (todo != null) {
                        final newTodos = List<TodoModel>.from(todos);
                        newTodos[index] = todo;
                        setState(() {
                          todos = newTodos;
                        });
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: todoModels.length,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // handle error state
            } else {
              return const Center(child: CircularProgressIndicator()); // handle loading state
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final todo = await Navigator.pushNamed(
            context,
            AddTodoPage.routeName,
            arguments: null,
          ) as TodoModel?;
          if (todo != null) {
            final newTodos = List<TodoModel>.from(todos);
            newTodos.add(todo);
            setState(() {
              todos = newTodos;
            });
          }
        },
      ),
    );
  }
  // void navigateToAddPage() {
  //   final route = MaterialPageRoute(
  //     builder: (context) => const AddTodoPage(),
  //   );
  //   Navigator.push(context, route);
  // }
// Future<void> fetchTodo() async
// {
//   const url =  'https://api.nstack.in/v1/todos?page=1&limit=10';
//   final uri = Uri.parse(url);
//   final response = await http.get(uri);
//   if(response.statusCode==200){
//     final json = jsonDecode(response.body) as Map;
//     final result = json['items'] as List;
//     setState(() {
//       items = result;
//
//     });
//   }
//   else{
//
//   }
//   print(response.body);
// }
}


