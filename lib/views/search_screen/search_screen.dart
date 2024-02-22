import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/widgets/app_bar/appbar_title_edittext.dart';
import 'package:job_estate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 11.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(indent: 6.w),
                      SizedBox(height: 26.h),
                      GestureDetector(
                          onTap: () {
                            onTapTxtNikeAirMaxReact(context);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Text("Demo Text",
                                  style: theme.textTheme.bodySmall))),
                      SizedBox(height: 37.h),
                      Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text("Demo Text",
                              style: theme.textTheme.bodySmall)),
                      SizedBox(height: 34.h),
                      Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child:Text("Demo Text",
                              style: theme.textTheme.bodySmall)),
                      SizedBox(height: 36.h),
                      Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text("Demo Text",
                              style: theme.textTheme.bodySmall)),
                      SizedBox(height: 37.h),
                      Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text("Demo Text",
                              style: theme.textTheme.bodySmall)),
                      SizedBox(height: 35.h),
                      Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text("Demo Text",
                              style: theme.textTheme.bodySmall)),
                      SizedBox(height: 5.h)
                    ]))));
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: AppbarTitleEdittext(
            margin: EdgeInsets.only(left: 16.h),
            hintText: "lbl_nike_air_max",
            controller: searchController),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMicIcon, margin: EdgeInsets.all(16.h))
        ]);
  }


  onTapTxtNikeAirMaxReact(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.searchResultScreen);
  }
}
