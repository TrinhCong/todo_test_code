import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_code/app/utils/datetime_helper.dart';
import 'package:todo_test_code/app/utils/dialogs.dart';
import 'package:todo_test_code/data/models/identity/todo.dart';
import 'package:todo_test_code/ui/components/app_icon.dart';
import 'package:todo_test_code/ui/components/app_icon_button.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';
import 'package:todo_test_code/ui/components/texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_test_code/ui/pages/todo/controller.dart';

class TodoCardController extends GetxController {
  var data = Todo().obs;
  var isFirst = true.obs;
  var updating = false.obs;
  var userName = "";
  var password = "";
  var otpCode = "";
  void close(bool value) {
    Get.back<bool>(result: false);
    userName = "";
    password = "";
    isFirst.value = value;
  }
}

class TodoCard extends StatefulWidget {
  Todo data;
  TodoCard({Key? key, required this.data}) : super(key: key);
  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late TodoCardController _controller;
  final parentController = TodoController.instance;
  @override
  void initState() {
    super.initState();
    _controller = TodoCardController();
    _controller.data.value = widget.data;
    Get.put(_controller, tag: _controller.data.value.key);
  }

  toggleTodo(value) async {
    var ok = await Dialogs.confirm(
        message:
            "Are you sure to mark this todo item as ${value ? "done" : "not done"}?");
    if (ok) {
      _controller.data.value.done = value;
      await parentController.edit(_controller.data.value);
    }
  }

  deleteTodo(Todo item) async {
    var ok = await Dialogs.confirm(
        message: "Are you sure to delete this todo ${item.name}?");
    if (ok) {
      await parentController.delete(item.key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: _controller.data.value.done
                ? AppTheme.backgroundColorLight
                : AppTheme.disabledColor.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
              child: Icon(
                Icons.file_copy,
                size: MediaQuery.of(context).size.width * .16 > 100
                    ? 100
                    : MediaQuery.of(context).size.width * .16,
                color: _controller.data.value.done
                    ? AppTheme.successColor
                    : AppTheme.errorColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 8),
                          child: Text(
                            _controller.data.value.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      Obx(() => Checkbox(
                            value: _controller.data.value.done,
                            onChanged: toggleTodo,
                          )),
                      AppIconButton(
                        iconData: AppIcons.trashCan,
                        color: Colors.red,
                        onPressed: () async {
                          await deleteTodo(_controller.data.value);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisabledText(
                          "Name: ${_controller.data.value.name}",
                          dense: true,
                        ),
                        DisabledText(
                          "Description: ${_controller.data.value.description}",
                          dense: true,
                        ),
                        DisabledText(
                          "Status: ${_controller.data.value.done ? 'done' : 'pending'}",
                          dense: true,
                        ),
                        if (_controller.data.value.createdDate != null)
                          DisabledText(
                            "Created date: ${DateTimeHelpers.formatDDMMYYYY(_controller.data.value.createdDate!)}",
                            dense: true,
                          ),
                        if (_controller.data.value.updatedDate != null)
                          DisabledText(
                            "Finished date: ${DateTimeHelpers.formatDDMMYYYY(_controller.data.value.updatedDate!)}",
                            dense: true,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class _MenuItem extends StatelessWidget {
  VoidCallback? onTap;
  final String iconData;
  final String title;
  _MenuItem({
    Key? key,
    this.onTap,
    required this.iconData,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
        child: Row(
          children: <Widget>[
            AppIcon(
              iconData,
            ),
            Container(
              margin: EdgeInsets.only(left: 8.h),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.h,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
