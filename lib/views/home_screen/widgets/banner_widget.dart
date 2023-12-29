import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';

class BannerWidget extends StatelessWidget {
  final String totalJobs,newJobs,postedToday;
  const BannerWidget({Key? key, required this.totalJobs, required this.newJobs, required this.postedToday})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.v,
      width: 343.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.redAccent],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(
                8.h,
              ),
            ),
            height: 160.v,
            width: 343.h,
            alignment: Alignment.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BannerText(title: "Total Jobs", value: totalJobs),
                    BannerText(title: "New Jobs", value: newJobs),
                    BannerText(title: "Posted Today", value: postedToday),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BannerText extends StatelessWidget {
  final String title, value;
  const BannerText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 10.v,
            bottom: 9.v,
          ),
          child: Text(
            title,
            style: CustomTextStyles.titleSmallOnPrimaryContainer,
          ),
        ),
        Container(
          width: 80.h,
          padding: EdgeInsets.symmetric(
            horizontal: 9.h,
            vertical: 8.v,
          ),
          decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
