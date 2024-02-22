import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOnJobList extends StatelessWidget {
  const ShimmerOnJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => SizedBox(
          height: 150.h,
          width: 230.w,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50.0.h,
                        height: 50.0.w,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.0.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 230.w,
                            height: theme.textTheme.titleLarge!.fontSize,
                            color: Colors.white,
                          ),
                          SizedBox(height: 6.0.h),
                          Container(
                            width: double.infinity,
                            height: theme.textTheme.bodyMedium!.fontSize,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        width: 24.0.h,
                        height: 24.0.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0.h),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Container(
                      width: 150.w,
                      height: theme.textTheme.titleMedium!.fontSize,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6.0.h),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
                    child: Container(
                      width: 200.w,
                      height: theme.textTheme.bodySmall!.fontSize,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
