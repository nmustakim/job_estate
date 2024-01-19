
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/user/applied_jobs_controller.dart';
import 'package:job_estate/views/home_screen/widgets/job_card.dart';

import '../../constants/image_constant.dart';
import '../../controllers/jobs/job_states.dart';
import '../../models/job_model.dart';

import '../../utils/size_utils.dart';

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
    mediaQueryData = MediaQuery.of(context);
    final jobsState = ref.watch(appliedJobsProvider);
    final jobs = jobsState is FetchUserAppliedJobsSuccessState
        ? jobsState.appliedJobs
        : [];
    return Scaffold(
        appBar: CustomAppBar(
            leadingWidth: 40.h,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeftBlueGray300,
                margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
                onTap: () {
                  Navigator.pop(context);
                }),
            title: AppbarSubtitle(
                text: "Applied jobs", margin: EdgeInsets.only(left: 12.h))),
        body: Padding(
            padding: EdgeInsets.only(left: 16.h, top: 8.v, right: 16.h),
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
