import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test_code/app/global/bindings.dart';
import 'package:todo_test_code/app/global/app_navigator.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // doing smth
    });
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (Platform.isAndroid) {
        }
        //AdsAdmobUtils.showOpenAd();
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        if (Platform.isAndroid) {
        }
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(360, 768),
      builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Todo Test App',
              onGenerateRoute: AppNavigator.onGenerateRoute,
              initialBinding: AppBindings(),
              locale:const Locale('vi', 'VN'),
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              initialRoute: AppNavigator.initialRoute,
              localizationsDelegates:const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
    );
  }
}
