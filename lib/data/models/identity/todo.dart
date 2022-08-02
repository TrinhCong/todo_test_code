import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String key;
  String name;
  String description;
  bool done;
  DateTime? createdDate;
  DateTime? updatedDate;
  Todo({
    this.key = "",
    this.name = "",
    this.description = "",
    this.done = false,
    this.createdDate,
    this.updatedDate,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

@JsonSerializable()
class TodosResponse {
  List<Todo>? data;

  TodosResponse({
    this.data,
  });
  factory TodosResponse.fromJson(Map<String, dynamic> json) =>
      _$TodosResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TodosResponseToJson(this);
}
