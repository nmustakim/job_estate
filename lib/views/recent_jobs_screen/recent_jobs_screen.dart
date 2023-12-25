import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/views/home_screen/widgets/job_card_list.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar_job_list.dart';

import '../../models/job_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';


class RecentJobsScreen extends StatelessWidget {
  const RecentJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
          leadingWidth: 50.v,
          leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeftBlueGray300,
              margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
              onTap: () {
                Navigator.pop(context);
              }),
          title: AppbarSubtitle(
              text: "Recent jobs", margin: EdgeInsets.only(left: 12.h))),
      body: JobCardList(jobsList: []),
    );
  }
}