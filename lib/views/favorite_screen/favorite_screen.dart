
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/views/home_screen/widgets/job_card.dart';

import '../../constants/image_constant.dart';
import '../../controllers/jobs/fetch_jobs_controller.dart';
import '../../controllers/jobs/job_states.dart';
import '../../models/job_model.dart';

import '../../utils/size_utils.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/job_details.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  void initState() {
  ref.read(jobsProvider.notifier).fetchJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final jobsState = ref.watch(jobsProvider);
    final jobs = jobsState is FetchJobsSuccessState ? jobsState.jobsList:[];
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Padding(
                padding: EdgeInsets.only(left: 16.h, top: 8.v, right: 16.h),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return JobCard(job: job, onTap: () { onTapJobCard(context,job); },);
                    }))));
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftBlueGray300,
            margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "Favorite jobs",
            margin: EdgeInsets.only(left: 12.h)));
  }


  onTapJobCard(BuildContext context, Job job) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDetails(
              job: job,)));
  }


  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
