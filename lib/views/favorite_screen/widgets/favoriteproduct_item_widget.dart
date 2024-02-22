import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';


class FavoriteItemWidget extends StatelessWidget {
  FavoriteItemWidget({
    Key? key,
    this.onTapProductItem,
  }) : super(
          key: key,
        );

  VoidCallback? onTapProductItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapProductItem!.call();
      },
      child: Container(
        padding: EdgeInsets.all(15.h),
        decoration: AppDecoration.outlineBlue50.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath:" ImageConstant.imgProductImage2",
              height: 133.h,
              width: 133.w,
              radius: BorderRadius.circular(
                5.r,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: 107.w,
              child: Text(
                "Demo Text",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge!.copyWith(
                  height: 1.50,
                ),
              ),
            ),
       
            SizedBox(height: 18.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Demo Text",
                      style: CustomTextStyles.labelLargePrimary,
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: 91.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Demo Text",
                            style: CustomTextStyles.bodySmall10.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            "Demo Text",
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgTrashIcon,
                  height: 24.h,
                  width: 24.w,
                  margin: EdgeInsets.only(
                    left: 17.w,
                    top: 14.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
