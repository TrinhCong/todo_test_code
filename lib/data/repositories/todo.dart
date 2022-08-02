import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test_code/app/utils/string_helper.dart';
import 'package:todo_test_code/data/models/identity/todo.dart';
import 'package:uuid/uuid.dart';

abstract class ITodoRepository {
  Future<List<Todo>?> list();
  Future<bool> exists(Todo item);
  Future<bool?> add(Todo item);
  Future<bool?> update(Todo item);
  Future<bool?> delete(String key);
}

class TodoRepository extends ITodoRepository {
  final SharedPreferences _prefs;
  final String _key = "todos";
  TodoRepository(this._prefs);
  Future<List<Todo>?> list() async {
    var response = TodosResponse();
    var dataStr = _prefs.getString(_key);
    if (StringHelper.isNotNullOrEmpty(dataStr)) {
      var dataJson = json.decode(dataStr!);
      response = TodosResponse.fromJson(dataJson);
    }
    return response.data;
  }

  Future<bool> exists(Todo item) async {
    var items = (await list()) ?? [];
    return items.any((element) =>
        element.key != item.key && element.name.trim() == item.name.trim());
  }

  Future<bool?> add(Todo item) async {
    var items = (await list()) ?? [];
    item.key = Uuid().v1().toString();
    items.add(item);
    var rp = TodosResponse(data: items);
    var jsonData = rp.toJson();
    return (await _prefs
        .setString(_key, json.encode(jsonData))
        .catchError((error) {}));
  }

  Future<bool?> update(Todo item) async {
    var items = (await list()) ?? [];
    var existItem = items.firstWhere((e) => e.key == item.key);
    existItem.name = item.name;
    existItem.description = item.description;
    existItem.done = item.done;
    existItem.updatedDate = item.updatedDate;
    var rp = TodosResponse(data: items);
    var jsonData = rp.toJson();
    return (await _prefs
        .setString(_key, json.encode(jsonData))
        .catchError((error) {}));
  }

  Future<bool?> delete(String key) async {
    var items = (await list()) ?? [];
    var existItem = items.removeWhere((e) => e.key == key);
    var rp = TodosResponse(data: items);
    var jsonData = rp.toJson();
    return (await _prefs
        .setString(_key, json.encode(jsonData))
        .catchError((error) {}));
  }
}
