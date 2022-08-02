import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test_code/data/models/identity/todo.dart';
import 'package:todo_test_code/data/repositories/todo.dart';
import 'package:todo_test_code/ui/pages/todo/controller.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences, permanent: true);
  }
}

class TodoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ITodoRepository>(
        () => TodoRepository(Get.find<SharedPreferences>()));
    Get.lazyPut(() => TodoController(Get.find<ITodoRepository>()));
  }
}
