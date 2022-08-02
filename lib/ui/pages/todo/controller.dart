import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_code/app/global/app_navigator.dart';
import 'package:todo_test_code/app/utils/dialogs.dart';
import 'package:todo_test_code/app/utils/string_helper.dart';
import 'package:todo_test_code/data/models/identity/todo.dart';
import 'package:todo_test_code/data/repositories/todo.dart';
import 'package:todo_test_code/ui/pages/todo/todo.dart';

class TodoController extends GetxController {
  static TodoController get instance => Get.find();
  var data = <Todo>[].obs;
  var currentItem = Todo().obs;
  final ITodoRepository _repository;
  TodoController(this._repository);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timer) async {
      await _loadData();
    });
  }

  _loadData() async {
    data.value = [];
    await Future.delayed(Duration(milliseconds: 100));
    data.value = (await _repository.list()) ?? [];
    data.value = data.value.reversed.toList();
    data.refresh();
  }

  back() {
    Get.back();
  }

  save() async {
    if (StringHelper.isNullOrEmpty(currentItem.value.name)) {
      Dialogs.alert(message: "Please enter Todo Name!");
    } else {
      var isExist = await _repository.exists(currentItem.value);
      if (isExist) {
        Dialogs.alert(
            message:
                "Todo Name '${currentItem.value.name}' is exist. Please enter another!");
      } else {
        Dialogs.showProgress();
        currentItem.value.createdDate = DateTime.now();
        var result = await _repository.add(currentItem.value);
        Dialogs.hideProgress();
        if (!(result??false)) {
          Dialogs.alert(message: "Add new todo fail! Please try again later!");
        } else {
          back();
          currentItem.value = Todo();
          _loadData();
        }
      }
    }
  }

  edit(Todo item) async {
    var isExist = await _repository.exists(item);
    if (isExist) {
      Dialogs.alert(
          message:
              "Todo Name '${currentItem.value.name}' is exist. Please enter another!");
    } else {
      Dialogs.showProgress();
      item.updatedDate = DateTime.now();
      var result = await _repository.update(item);
      Dialogs.hideProgress();
      if (!(result??false)) {
        Dialogs.alert(message: "Update todo fail! Please try again later!");
      } else {
        _loadData();
      }
    }
  }

  delete(String key) async {
    Dialogs.showProgress();
    var result = await _repository.delete(key);
    Dialogs.hideProgress();
    _loadData();
  }
}
