import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';

import '../../widgets/app_bar/appbar_title_edittext_one.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../search_result_screen/widgets/searchresult_item_widget.dart';
import 'package:flutter/material.dart';


class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 11.h),
                child: Column(children: [
                  Divider(),
                  SizedBox(height: 15.h),
                  _buildResultCounter(context),
                  SizedBox(height: 16.h),
                  _buildSearchResult(context)
                ]))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: AppbarTitleEdittextOne(
            margin: EdgeInsets.only(left: 16.h),
            hintText: "Demo text",
            controller: searchController),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSort,
              margin: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
              onTap: () {
                onTapSort(context);
              }),
          AppbarTrailingImage(
              imagePath: ImageConstant.imgFilter,
              margin: EdgeInsets.only(left: 16.h, top: 16.h, right: 32.h),
              onTap: () {
                onTapFilter(context);
              })
        ]);
  }

  Widget _buildResultCounter(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                  opacity: 0.5,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text("Demo",
                          style: CustomTextStyles.labelLargeOnPrimary))),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 3.h),
                  child: Text("Demo",
                      style: theme.textTheme.labelLarge)),
              CustomImageView(
                  imagePath: ImageConstant.imgDownIcon,
                  height: 24.h,
                  width: 24.w,
                  margin: EdgeInsets.only(left: 8.h))
            ]));
  }

  Widget _buildSearchResult(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 283.h,
                    crossAxisCount: 2,
                    mainAxisSpacing: 13.h,
                    crossAxisSpacing: 13.h),
                physics: BouncingScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return SearchResultItemWidget();
                })));
  }

  onTapSort(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sortByScreen);
  }

  onTapFilter(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.filterScreen);
  }
}
