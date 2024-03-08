import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../models/responses/todo_responses.dart';
import '../models/todo_model.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging-interceptor.dart';

 class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ),
  )..interceptors.addAll(
      [
        AuthInterceptor(),
        LoggingInterceptor(),
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          compact: true,
        ),
      ],
    );

  // final _baseUrl = 'https://dummyjson.com';

  Future<TodoResponse?> getTodos() async {
    try {
      final todoData = await _dio.get('https://api.nstack.in/v1/todos?page=1&limit=10');
      final todoResponse = TodoResponse.fromJson(todoData.data);

      return todoResponse;
    } on DioException catch (_) {
      return null;
    }
  }

  Future<TodoModel?> createTodo({
    required TodoModel todoModel,
  }) async {
    try {
      final response = await _dio.post(
        'https://api.nstack.in/v1/todos',
        data: todoModel.toJson(),
      );
      final todoResponse = TodoModel.fromJson(response.data);

      return todoResponse;
    } on DioException catch (_) {
      return null;
    }
  }

  Future<TodoModel?> updateTodo({
    required String id,
    required TodoModel todoModel,
  }) async {
    try {
      final response = await _dio.put(
        'https://api.nstack.in/v1/todos/$id',
        data: todoModel.toJson(),
      );
      final todoResponse = TodoModel.fromJson(response.data);

      return todoResponse;
    } on DioException catch (_) {
      return null;
    }
  }

  Future<TodoModel?> deleteTodo({
    required String id,
  }) async {
    try {
      final response = await _dio.delete('https://api.nstack.in/v1/todos/$id');
      final todoResponse = TodoModel.fromJson(response.data);

      return todoResponse;
    } on DioException catch (_) {
      return null;
    }
  }
}
