import 'package:json_annotation/json_annotation.dart';

import '../todo_model.dart';
part 'todo_responses.g.dart';

@JsonSerializable()
class TodoResponse {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "timestamp")
  int timestamp;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "items")
  List<TodoModel> todos;
  @JsonKey(name: "meta")
  Map<String, dynamic> meta; // Change the type to Map<String, dynamic>

  TodoResponse({
    required this.code,
    required this.success,
    required this.timestamp,
    required this.message,
    required this.todos,
    required this.meta,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) => _$TodoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoResponseToJson(this);
}