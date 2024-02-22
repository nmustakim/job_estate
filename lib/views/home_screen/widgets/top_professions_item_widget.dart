
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';


class TopProfessionItemWidget extends StatelessWidget {
  final String title, icon;
  final VoidCallback onTap;

  const TopProfessionItemWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
        decoration: AppDecoration.outlineBlue.copyWith(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
        width: 140.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: icon,
              height: 40.h,
              width: 40.w,
              radius: BorderRadius.circular(
                5.h,
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium!.copyWith(
                height: 1.50,
              ),
            ),
            SizedBox(height: 11.h),
          ],
        ),
      ),
    );
  }
}
