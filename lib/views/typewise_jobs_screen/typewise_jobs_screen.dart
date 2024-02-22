import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/controllers/jobs/typewise_job_controller.dart';

import 'package:job_estate/views/home_screen/widgets/job_card_list.dart';


import '../../constants/image_constant.dart';
import '../../controllers/jobs/job_states.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';


class TypeWiseJobsScreen extends ConsumerStatefulWidget {
  final String title;
  const TypeWiseJobsScreen({super.key, required this.title});

  @override
  ConsumerState<TypeWiseJobsScreen> createState() => _TypeWiseJobsScreenState();
}

class _TypeWiseJobsScreenState extends ConsumerState<TypeWiseJobsScreen> {
  @override
  Widget build(BuildContext context) {

    final jobsState = ref.watch(typeWiseJobsProvider);
    final jobs = jobsState is FetchTypeWiseJobsSuccessState ? jobsState.typeWiseJobs:[];
    return Scaffold(
        appBar: CustomAppBar(
            leadingWidth: 50.w,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeftBlueGray300,
                margin: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 15.h),
                onTap: () {
                  Navigator.pop(context);
                }),
            height: 50.h,
            title: AppbarSubtitle(
                text: "${widget.title} jobs",
                margin: EdgeInsets.only(left: 12.w))),
        body: JobCardList(jobsList: jobs),


    );
  }
}