
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';

import 'package:job_estate/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(
              5.r,
            ),
          ),
        ),
      );

  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
