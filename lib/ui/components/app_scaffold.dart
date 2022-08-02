import 'package:flutter/material.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScaffold extends StatefulWidget {
  Widget body;
  String title;
  bool showNotificationButton;
  bool showLogo;
  List<Widget> actions;
  AppScaffold(
      {Key? key,
      required this.body,
      this.title = "",
      this.actions = const [],
      this.showLogo = true,
      this.showNotificationButton = true})
      : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final _globalKey = GlobalKey<ScaffoldState>();

  var isDark = false;

  void setAppState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        backgroundColor: AppTheme.backgroundColor,
        body: Column(children: [
          Container(
            padding: EdgeInsets.only(
                left: 12.h, right: 12.h, top: 24.h, bottom: 8.h),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColorLight,
            ),
            child: Row(children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 8.h,
              ),
              if (widget.showLogo)
                InkWell(
                  onTap: () {
                    _globalKey.currentState?.openDrawer();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0),
                    radius: 20.h,
                    child: Image.asset("assets/icons/logo.png"),
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: AppTheme.primaryColorDark,
                          fontWeight: FontWeight.w900,
                          overflow: TextOverflow.clip,
                          fontSize: 18.h),
                    ),
                  ),
                ),
              ),
              ...widget.actions,
            ]),
          ),
          Expanded(
            child: widget.body,
          ),
        ]));
  }
}
