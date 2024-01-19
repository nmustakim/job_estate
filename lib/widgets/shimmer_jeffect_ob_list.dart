import 'package:flutter/material.dart';
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
          height: 150.v,
          width: 230.h,
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
                        width: 50.0.adaptSize,
                        height: 50.0.adaptSize,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.0.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 230.v,
                            height: theme.textTheme.titleLarge!.fontSize,
                            color: Colors.white,
                          ),
                          SizedBox(height: 6.0.v),
                          Container(
                            width: double.infinity,
                            height: theme.textTheme.bodyMedium!.fontSize,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        width: 24.0.adaptSize,
                        height: 24.0.adaptSize,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0.v),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Container(
                      width: 150.v, // Adjust the width as needed
                      height: theme.textTheme.titleMedium!.fontSize,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6.0.v),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h, bottom: 8.v),
                    child: Container(
                      width: 200.v, // Adjust the width as needed
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
