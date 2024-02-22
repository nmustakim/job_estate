
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/controllers/user/applied_jobs_controller.dart';
import 'package:job_estate/views/home_screen/widgets/job_card.dart';

import '../../constants/image_constant.dart';
import '../../controllers/jobs/job_states.dart';
import '../../models/job_model.dart';


import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/job_details.dart';

class AppliedJobsScreen extends ConsumerStatefulWidget {
  const AppliedJobsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AppliedJobsScreen> createState() => _AppliedJobsScreenState();
}

class _AppliedJobsScreenState extends ConsumerState<AppliedJobsScreen> {


  @override
  Widget build(BuildContext context) {

    final jobsState = ref.watch(appliedJobsProvider);
    final jobs = jobsState is FetchUserAppliedJobsSuccessState
        ? jobsState.appliedJobs
        : [];
    return Scaffold(
        appBar: CustomAppBar(
            leadingWidth: 40.w,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeftBlueGray300,
                margin: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 15.h),
                onTap: () {
                  Navigator.pop(context);
                }),
            title: AppbarSubtitle(
                text: "Applied jobs", margin: EdgeInsets.only(left: 12.w))),
        body: Padding(
            padding: EdgeInsets.only(left: 16.w, top: 8.h, right: 16.w),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return JobCard(
                    job: job,
                    onFavScreen: false,
                    onTap: () {
                      onTapJobCard(context, job);
                    },
                  );
                })));
  }

  onTapJobCard(BuildContext context, Job job) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDetails(
                  job: job,
                )));
  }
}
