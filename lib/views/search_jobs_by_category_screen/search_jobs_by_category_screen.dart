import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/models/profession_model.dart';
import 'package:job_estate/views/search_jobs_by_category_screen/widgets/profession_item_widget.dart';

import '../../widgets/app_bar/appbar_title_searchview.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

// ignore: must_be_immutable
class SearchJobsByCategoryScreen extends StatelessWidget {
  SearchJobsByCategoryScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();
  List<Profession> professions = [
    
    Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
    Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
    Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
    Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
            Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
    Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
    Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
    Profession(
        professionTitle: "Programming",
        professionImage: ImageConstant.imgProgramming),
    Profession(
        professionTitle: "Design", professionImage: ImageConstant.imgDesign),
    Profession(
        professionTitle: "Engineering",
        professionImage: ImageConstant.imgEngineering),
    Profession(
        professionTitle: "Accounting",
        professionImage: ImageConstant.imgAccounting),
  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
                  child: Column(children: [
                    _buildProfessionCategory(context),
                    SizedBox(height: 5.h)
                  ])),
            )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: AppbarTitleSearchview(
            margin: EdgeInsets.only(left: 16.w,top: 10.h),
            hintText: "Search Jobs",
            controller: searchController),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgDownload,
              margin: EdgeInsets.only(left: 16.h, top: 16.h, right: 16.h)),
          Container(
              height: 24.h,
              width: 24.w,
              margin: EdgeInsets.only(left: 16.h, top: 16.h, right: 32.h),
              child: Stack(alignment: Alignment.topRight, children: [
                CustomImageView(
                    imagePath: ImageConstant.imgNotificationIcon,
                    height: 24.h,
                    width: 24.w,
                    alignment: Alignment.center,
                    onTap: () {
                      onTapImgNotificationIcon(context);
                    }),
                CustomImageView(
                    imagePath: ImageConstant.imgClosePink300,
                    height: 8.h,
                    width: 8.w,
                    alignment: Alignment.topRight,
                    margin:
                        EdgeInsets.only(left: 14.h, right: 2.h, bottom: 16.h))
              ]))
        ]);
  }

  Widget _buildProfessionCategory(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 115.h,
              crossAxisCount: 3,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 21.h),
          physics: NeverScrollableScrollPhysics(),
          itemCount: professions.length,
          itemBuilder: (context, index) {
            final profession = professions[index];
            return ProfessionItemWidget(
              title:profession.professionTitle ,
              image:profession.professionImage, onTap: () {  } ,
              
            );
          })
    ]);
  }

  onTapImgNotificationIcon(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notificationScreen);
  }
}
