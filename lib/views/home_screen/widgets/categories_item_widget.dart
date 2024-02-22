import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/widgets/custom_icon_button.dart';


class CategoriesItemWidget extends StatelessWidget {
  const CategoriesItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.w,
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Column(
          children: [
            CustomIconButton(
              height: 70.h,
              width: 70.w,
              padding: EdgeInsets.fromLTRB(23.w, 23.h, 23.w, 23.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgArrowLeftPrimary,
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              "Title",
              style: CustomTextStyles.bodySmall10,
            ),
          ],
        ),
      ),
    );
  }
}
