import 'package:flutter/material.dart';
import 'package:job_estate/utils/size_utils.dart';

import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';


class CustomDropdownFormField extends FormField<String> {
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final String? hintText;

  CustomDropdownFormField({this.hintText,
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
        padding:  EdgeInsets.only(left: 9.h,right: 10.h),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: UnderlineInputBorder( borderSide: BorderSide(color: Colors.white))
          ),
          value: state.value,
          hint: Text(hintText??"Please select an option",style:  CustomTextStyles.labelLargeOnPrimary,),
          items: items.map((String value) {
            return DropdownMenuItem<String>(

              value: value,
              child: Padding(
                padding:  EdgeInsets.only(left: 4.0.v),
                child: Text(value,style: theme.textTheme.bodyMedium ,overflow: TextOverflow.ellipsis,),
              ),
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
