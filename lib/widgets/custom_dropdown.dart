import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';

class CustomDropdownFormField extends FormField<String> {
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final double? leftPadding;

  CustomDropdownFormField({this.leftPadding,
    this.hintText,
    required this.items,
    this.onChanged,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue,
    bool enabled = true,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<String> state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w,),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:BorderSide.none)),
                value: state.value,
                hint: Padding(
                  padding:  EdgeInsets.only(left: leftPadding?.w??0.0),
                  child: Text(
                    hintText ?? "Please select an option",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                        width: 300.w,
                        child: Padding(
                          padding:  EdgeInsets.only(left: leftPadding?.w??0.0),
                          child: Text(
                            value,
                            style: CustomTextStyles.labelLargeOnPrimary,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  );
                }).toList(),
                onChanged: enabled
                    ? (String? value) {
                        state.didChange(value);
                        if (onChanged != null) {
                          onChanged(value!);
                        }
                      }
                    : null,
              ),
            );
          },
        );
}
