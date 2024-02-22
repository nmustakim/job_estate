import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';

class ProfileItem extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  Function? onTapProfileDetailOption;

  ProfileItem(
      {required this.icon, required this.title, required this.value,this.onTapProfileDetailOption});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapProfileDetailOption!.call();
        },
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(children: [
              CustomImageView(
                  imagePath: icon,
                  height: 24.h,
                  width: 24.w),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 3.h, bottom: 2.h),
                  child: Text(title,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1)))),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 3.h),
                  child: Text(value,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: appTheme.blueGray300))),
              CustomImageView(
                  imagePath: ImageConstant.imgEdit,
                  height: 16.h,
                  width: 16.w,
                  margin: EdgeInsets.only(left: 16.h))
            ])));
  }
}
