import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';


class SearchResultItemWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineBlue50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath:"",
            height: 133.h,
            width: 133.w,
            radius: BorderRadius.circular(
              5.r,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 107.w,
            child: Text("Demo Text",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge!.copyWith(
                height: 1.50,
              ),
            ),
          ),

          SizedBox(height: 18.h),
          Text("Demo Text",
            style: CustomTextStyles.labelLargePrimary,
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text("Demo Text",
                style: CustomTextStyles.bodySmall10.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text("Demo Text",
                  style: theme.textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
