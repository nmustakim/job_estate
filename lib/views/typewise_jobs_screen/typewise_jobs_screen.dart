import 'package:flutter/material.dart';
import 'package:job_estate/utils/size_utils.dart';
import 'package:job_estate/views/home_screen/widgets/job_card_list.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar_job_list.dart';

import '../../constants/image_constant.dart';
import '../../models/job_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';


class TypeWiseJobsScreen extends StatelessWidget {
  final String title;
  const TypeWiseJobsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            leadingWidth: 50.v,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeftBlueGray300,
                margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
                onTap: () {
                  Navigator.pop(context);
                }),
            height: 50.v,
            title: AppbarSubtitle(
                text: "$title jobs",
                margin: EdgeInsets.only(left: 12.h))),
        body: JobCardList(jobsList: []),
     

    );
  }
}