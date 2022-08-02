import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_code/app/global/bindings.dart';
import 'package:todo_test_code/ui/pages/splash/splash.dart';
import 'package:todo_test_code/ui/pages/todo/todo.dart';

class AppNavigator extends GetxController {
  static const DEFAULT_DURATION = Duration(milliseconds: 300);
  static var initialRoute = SplashPage.route;
  static var firstPageRoute = SplashPage.route;
  static var readTransition = Transition.rightToLeftWithFade;
  static var changed = true;

  static var currentRoute = SplashPage.route.obs;

  static Future<dynamic> toNamed(String routeName, {dynamic arguments}) async {
    currentRoute.value = routeName;
    var result = await Get.toNamed(routeName, arguments: arguments);
    return result;
  }

  static until(String routeName) {
    currentRoute.value = routeName;
    Get.until((route) => route.settings.name == routeName);
  }

  static Route onGenerateRoute(RouteSettings settings) {
    if (currentRoute.value != settings.name) {
      changed = true;
      currentRoute.value = settings.name ?? SplashPage.route;
    }
    switch (settings.name) {
      case TodoPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => TodoPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.fadeIn,
          binding: TodoBindings(),
        );
      default:
        return GetPageRoute(
          settings: settings,
          page: () => SplashPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeftWithFade,
        );
    }
  }
}
