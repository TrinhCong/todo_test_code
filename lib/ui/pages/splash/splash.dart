import 'package:flutter/material.dart';
import 'package:todo_test_code/app/global/app_navigator.dart';
import 'package:todo_test_code/ui/pages/todo/todo.dart';

class SplashPage extends StatefulWidget {
  static const String route = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 2));
      AppNavigator.toNamed(TodoPage.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: size.width * 0.4,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
