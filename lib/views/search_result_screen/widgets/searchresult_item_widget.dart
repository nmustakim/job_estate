import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';

import '../../../theme/app_decoration.dart';
import '../../../widgets/custom_image_view.dart';


// ignore: must_be_immutable
class SearchresultItemWidget extends StatelessWidget {
  const SearchresultItemWidget({Key? key})
      : super(
          key: key,
        );

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
            height: 133.adaptSize,
            width: 133.adaptSize,
            radius: BorderRadius.circular(
              5.h,
            ),
          ),
          SizedBox(height: 8.v),
          SizedBox(
            width: 107.h,
            child: Text(
              "msg_nike_air_max_270",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge!.copyWith(
                height: 1.50,
              ),
            ),
          ),

          SizedBox(height: 18.v),
          Text(
            "lbl_299_43",
            style: CustomTextStyles.labelLargePrimary,
          ),
          SizedBox(height: 5.v),
          Row(
            children: [
              Text(
                "lbl_534_33",
                style: CustomTextStyles.bodySmall10.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text(
                  "lbl_24_off",
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
