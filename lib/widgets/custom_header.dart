import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';


class CustomHeader extends StatelessWidget {
  final String title;
  const CustomHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title,
            style:theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)
                .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1))),

      ]),
    );
  }
}
