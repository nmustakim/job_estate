
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:flutter/material.dart';


class AppDecoration {

  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue50,
      );
  static BoxDecoration get fillIndigoA => BoxDecoration(
        color: appTheme.indigoA200,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(1),
      );


  static BoxDecoration get outlineBlue => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.blue50,
          width: 1.r,
        ),
      );
  static BoxDecoration get outlineBlue50 => BoxDecoration(
        border: Border.all(
          color: appTheme.blue50,
          width: 1.r,
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(1),
          width: 1.r,
        ),
      );
}

class BorderRadiusStyle {

  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24.r,
      );
  static BorderRadius get circleBorder36 => BorderRadius.circular(
        36.r,
      );


  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.r,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.r,
      );
}



double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;


