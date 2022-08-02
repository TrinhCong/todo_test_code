import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_test_code/ui/components/app_icon.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';

class AppIconButton extends StatelessWidget {
  final String iconData;
  final VoidCallback? onPressed;
  final Color? color;
  final bool disabled;
  final double? size;
  const AppIconButton(
      {Key? key,
      required this.iconData,
      this.onPressed,
      this.color,
      this.size,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _color = color == null ? AppTheme.primaryColorDark : color;
    if (disabled) _color = AppTheme.disabledColorDark;
    double _size = size ?? 24;
    _size=_size.h;
    double _percent = _size /24;
    return InkWell(
      onTap: () {
        if (!disabled && onPressed != null) onPressed!();
      },
      child: Padding(
        padding: EdgeInsets.all(2 * _percent),
        child: Container(
          width: _size,
          height: _size,
          alignment: Alignment.center,
        padding: EdgeInsets.all(4 * _percent),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _color!.withOpacity(0.6),
                  _color.withOpacity(0.2),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.all(Radius.circular((6 * _percent)))),
          child: AppIcon(
            iconData,
            size: (20 * _percent),
          ),
        ),
      ),
    );
  }
}
