// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoResponse _$TodoResponseFromJson(Map<String, dynamic> json) => TodoResponse(
      code: json['code'] as int,
      success: json['success'] as bool,
      timestamp: json['timestamp'] as int,
      message: json['message'] as String,
      todos: (json['items'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$TodoResponseToJson(TodoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'timestamp': instance.timestamp,
      'message': instance.message,
      'items': instance.todos,
      'meta': instance.meta,
    };
