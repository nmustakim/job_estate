import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/widgets/custom_icon_button.dart';


class ProfessionItemWidget extends StatelessWidget {
  final String title, image;
    final VoidCallback onTap;
  ProfessionItemWidget({Key? key, required this.title, required this.image, required this.onTap})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onTap,
          height:70.h,
          width: 70.w,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: CustomImageView(
            imagePath: image,
            height: 30.h,width: 25.h,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
