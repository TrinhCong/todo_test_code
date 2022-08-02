import 'package:flutter/material.dart';
import 'package:todo_test_code/ui/components/app_theme.dart';
import 'package:todo_test_code/ui/components/text_field_container.dart';
import 'package:todo_test_code/ui/components/texts.dart';

class RoundedTextField extends StatelessWidget {
  final String? hintText;
  final String? label;
  final String? description;
  final IconData icon;
  final String? value;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  const RoundedTextField(
      {Key? key,
      this.value,
      this.hintText,
      this.description,
      this.label,
      this.icon = Icons.person,
      this.onChanged,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          SizedBox(
            height: 4,
          ),
        if (label != null) DisabledText(" " + label! + ": "),
        TextFieldContainer(
          child: TextField(
              onChanged: onChanged,
              cursorColor: AppTheme.primaryColor,
              controller: controller,
              decoration: InputDecoration(
                icon: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                ),
                hintText: hintText,
                border: InputBorder.none,
              ),
              readOnly: readOnly),
        ),
        if (description != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width * 0.8,
            child: DisabledText(
              description!,
              dense: true,
            ),
          )
      ],
    );
  }
}
