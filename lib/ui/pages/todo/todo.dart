import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_code/app/global/app_navigator.dart';
import 'package:todo_test_code/ui/components/app_buttons.dart';
import 'package:todo_test_code/ui/components/app_icon.dart';
import 'package:todo_test_code/ui/components/app_icon_button.dart';
import 'package:todo_test_code/ui/components/app_scaffold.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';
import 'package:todo_test_code/ui/components/todo_card.dart';
import 'package:todo_test_code/ui/components/rounded_text_field.dart';
import 'package:todo_test_code/ui/components/texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_test_code/ui/pages/todo/controller.dart';

class TodoPage extends GetView<TodoController> {
  static const route = '/todo';
  final controller = TodoController.instance;

  Future<bool> showAddTodo() async {
    var ok = await Get.dialog<bool>(
      SafeArea(child: StatefulBuilder(builder: (context, setState) {
        return Material(
          color: Colors.black.withOpacity(0.1),
          child: Column(
            children: [
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColorLight,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Create new Todo",
                        style: TextStyle(
                            color: AppTheme.primaryColorDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.h),
                      ),
                    ),
                    RoundedTextField(
                      hintText: "Todo Name",
                      value:controller.currentItem.value.name,
                      onChanged: (value) {
                        controller.currentItem.value.name=value;
                        controller.currentItem.refresh();
                      },
                    ),
                    RoundedTextField(
                      hintText: "Description",
                      value:controller.currentItem.value.description,
                      onChanged: (value) {
                        controller.currentItem.value.description=value;
                        controller.currentItem.refresh();
                      },
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppButton(
                            color: AppTheme.errorColor,
                            textColor: AppTheme.brightColor,
                            text: "Cancel",
                            onPressed: controller.back,
                          ),
                          AppButton(
                            color: AppTheme.successColor,
                            textColor: AppTheme.brightColor,
                            text: "Save",
                            onPressed: controller.save,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        );
      })),
      barrierDismissible: false,
    );
    return ok ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Todo List",
      actions: [
        AppIconButton(
          iconData: AppIcons.plus,
          onPressed: () async {
            await showAddTodo();
          },
        ),
      ],
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            if (controller.data.value == null){
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 8,
              ));
            }
            else {
              if (controller.data.value.length>0)
                return SingleChildScrollView(
                  child: Column(
                      children: controller.data.value
                          .map((e) => TodoCard(data: e))
                          .toList()),
                );
              else
                return Center(child: ErrorText("Has no todo"));
            }
          })),
    );
  }
}
