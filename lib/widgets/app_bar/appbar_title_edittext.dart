

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/widgets/custom_text_form_field.dart';



// ignore: must_be_immutable
class AppbarTitleEdittext extends StatelessWidget {
  AppbarTitleEdittext({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomTextFormField(
        width: 291.h,
        controller: controller,
        hintText: "Search Jobs",
        prefix: Container(
          margin: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 16.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgSearch,
            height: 16.h,
            width: 16.w,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 44.h,
        ),
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.w, 12.h, 16.w, 12.w),
          child: CustomImageView(
            imagePath: ImageConstant.imgClearIcon,
            height: 20.h,
            width: 20.w,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 44.h,
        ),
      ),
    );
  }
}
