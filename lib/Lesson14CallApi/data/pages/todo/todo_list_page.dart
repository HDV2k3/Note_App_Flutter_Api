// // import 'dart:convert';
// //
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// //
// // import '../../api/dio_client.dart';
// // import '../../models/responses/todo_responses.dart';
// // import '../../models/todo_model.dart';
// // import '../add_todo/add_todo.dart';
// // import '../add_todo/update_delete_todo.dart';
// // import 'widgets/todo_item.dart';
// //
// // // import 'package:http/http.dart' as http;
// // class TodoPage extends StatefulWidget {
// //   const TodoPage({Key? key}) : super(key: key);
// //   static const routeName = '/todo';
// //   @override
// //   State<TodoPage> createState() => _TodoPageState();
// // }
// //
// // class _TodoPageState extends State<TodoPage> {
// //   List<TodoModel> todos = [];
// //   final DioClient _client = DioClient();
// //   List items = []; // Used in the fetchTodo method
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Todo List'),
// //       ),
// //       body: SafeArea(
// //         child: FutureBuilder<TodoResponse?>(
// //           future: _client.getTodos(),
// //           builder: (context, snapshot) {
// //             if (snapshot.hasData) {
// //               final todoResponse = snapshot.data;
// //               final todoModels = todoResponse?.todos ??
// //                   []; // assuming the todos are directly in the response
// //               return ListView.separated(
// //                 padding: const EdgeInsets.symmetric(vertical: 16),
// //                 itemBuilder: (context, index) {
// //                   return TodoItem(
// //                     todo: todoModels[index],
// //                     onTap: () async {
// //                       final todo = await Navigator.pushNamed(
// //                         context,
// //                         UDTodoPage.routeName,
// //                         arguments: todoModels[index],
// //                       ) as TodoModel?;
// //                       if (todo != null) {
// //                         final newTodos = List<TodoModel>.from(todos);
// //                         newTodos[index] = todo;
// //                         setState(() {
// //                           todos = newTodos;
// //                         });
// //                       }
// //                     },
// //                   );
// //                 },
// //                 separatorBuilder: (context, index) {
// //                   return const SizedBox(
// //                     height: 16,
// //                   );
// //                 },
// //                 itemCount: todoModels.length,
// //               );
// //             } else if (snapshot.hasError) {
// //               return Center(
// //                   child:
// //                       Text('Error: ${snapshot.error}')); // handle error state
// //             } else {
// //               return const Center(
// //                   child: CircularProgressIndicator()); // handle loading state
// //             }
// //           },
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         child: const Icon(Icons.add),
// //         onPressed: () async {
// //           final todo = await Navigator.pushNamed(
// //             context,
// //             AddTodoPage.routeName,
// //             arguments: null,
// //           ) as TodoModel?;
// //
// //           if (todo != null) {
// //             setState(() {
// //               todos.add(todo);
// //             });
// //           }
// //         },
// //       ),
// //     );
// //   }
// //
// //   void navigateToAddPage() {
// //     final route = MaterialPageRoute(
// //       builder: (context) => const AddTodoPage(
// //         todo: null,
// //       ),
// //     );
// //     Navigator.push(context, route);
// //   }
// //
// //   Future<void> fetchTodo() async {
// //     const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
// //     final uri = Uri.parse(url);
// //     final response = await http.get(uri);
// //     if (response.statusCode == 200) {
// //       final json = jsonDecode(response.body) as Map;
// //       final result = json['items'] as List;
// //       setState(() {
// //         items = result; // Use the declared `items` variable
// //       });
// //     } else {}
// //     if (kDebugMode) {
// //       print(response.body);
// //     }
// //   }
// // }
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import '../../api/dio_client.dart';
// import '../../models/todo_model.dart';
// import '../add_todo/add_todo.dart';
// import '../add_todo/update_delete_todo.dart';
// import 'widgets/todo_item.dart';
//
// class TodoPage extends StatefulWidget {
//   const TodoPage({Key? key}) : super(key: key);
//   static const routeName = '/todo';
//
//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }
//
// class _TodoPageState extends State<TodoPage> {
//   List<TodoModel> todos = [];
//   final DioClient _client = DioClient();
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchTodos(); // Tải danh sách ban đầu
//   }
//
//   // Hàm tải danh sách Todos từ API
//   Future<void> fetchTodos() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       final response = await _client.getTodos();
//       setState(() {
//         todos = response?.todos ?? []; // Gán danh sách từ API
//         isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       if (kDebugMode) {
//         print('Error fetching todos: $error');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo List'),
//       ),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(
//                 child: CircularProgressIndicator()) // Trạng thái loading
//             : todos.isEmpty
//                 ? const Center(child: Text('No Todos available'))
//                 : ListView.separated(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     itemBuilder: (context, index) {
//                       return TodoItem(
//                         todo: todos[index],
//                         onTap: () async {
//                           final result = await Navigator.pushNamed(
//                             context,
//                             UDTodoPage.routeName,
//                             arguments: todos[index],
//                           );
//
//                           if (result != null) {
//                             final action = (result as Map)['action'];
//                             if (action == 'update') {
//                               // Cập nhật todo trong danh sách
//                               final updatedTodo = result['todo'] as TodoModel;
//                               setState(() {
//                                 todos[index] = updatedTodo;
//                               });
//                             } else if (action == 'delete') {
//                               // Xóa todo khỏi danh sách
//                               setState(() {
//                                 todos.removeAt(index);
//                               });
//                             }
//                           }
//                         },
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return const SizedBox(
//                         height: 16,
//                       );
//                     },
//                     itemCount: todos.length,
//                   ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           final result = await Navigator.pushNamed(
//             context,
//             AddTodoPage.routeName,
//           );
//
//           if (result != null) {
//             final newTodo = result as TodoModel;
//             setState(() {
//               todos.add(newTodo); // Thêm todo mới vào danh sách
//             });
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../api/dio_client.dart';
import '../../models/todo_model.dart';
import '../add_todo/add_todo.dart';
import '../add_todo/update_delete_todo.dart';
import 'widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);
  static const routeName = '/todo';

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<TodoModel> todos = [];
  final DioClient _client = DioClient();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTodos(); // Tải danh sách ban đầu
  }

  // Hàm tải danh sách Todos từ API
  Future<void> fetchTodos() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _client.getTodos();
      setState(() {
        todos = response?.todos ?? []; // Gán danh sách từ API
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print('Error fetching todos: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator()) // Trạng thái loading
            : todos.isEmpty
                ? const Center(child: Text('No Todos available'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (context, index) {
                      return TodoItem(
                        todo: todos[index],
                        onTap: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            UDTodoPage.routeName,
                            arguments: todos[index],
                          );

                          if (result != null) {
                            final action = (result as Map)['action'];
                            if (action == 'update') {
                              // Cập nhật todo trong danh sách
                              final updatedTodo = result['todo'] as TodoModel;
                              setState(() {
                                todos[index] = updatedTodo;
                              });
                            } else if (action == 'delete') {
                              // Xóa todo khỏi danh sách
                              setState(() {
                                todos.removeAt(index);
                              });
                            }
                          }

                          // Gọi lại hàm fetchTodos() sau khi xóa hoặc cập nhật
                          fetchTodos(); // Cập nhật lại danh sách todos
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: todos.length,
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            AddTodoPage.routeName,
          );

          if (result != null) {
            final newTodo = result as TodoModel;
            setState(() {
              todos.add(newTodo); // Thêm todo mới vào danh sách
            });
          }
        },
      ),
    );
  }
}
