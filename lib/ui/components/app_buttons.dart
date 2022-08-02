import 'package:flutter/material.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String? text;
  final VoidCallback? onPressed;
  const AppButton({Key? key, this.color, this.textColor, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: color ?? AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Text(text ?? "Gửi",
              style: TextStyle(
                  color: textColor ?? AppTheme.brightColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
