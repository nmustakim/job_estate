
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/user/favorite_jobs_controller.dart';
import 'package:job_estate/views/home_screen/widgets/job_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/image_constant.dart';
import '../../controllers/jobs/job_controller.dart';
import '../../controllers/jobs/job_states.dart';
import '../../core/states/base_states.dart';
import '../../models/job_model.dart';

import '../../theme/theme_helper.dart';
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
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final jobsState = ref.watch(favoriteJobsProvider);
    final jobs = jobsState is FetchUserFavoriteJobsSuccessState ? jobsState.favJobs:[];
    if (jobsState is LoadingState) {
      return _buildShimmerList();
    }
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
            padding: EdgeInsets.only(left: 16.h, top: 8.v, right: 16.h),
            child:jobs.isEmpty
                ? _buildEmptyMessage()
                : ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return JobCard(job: job, onTap: () { onTapJobCard(context,job); },);
                })));

  }
  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        "No favorite jobs found.",
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child:ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) =>  Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50.0.adaptSize,
                    height: 50.0.adaptSize,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 230.v,
                        height: theme.textTheme.titleLarge!.fontSize,
                        color: Colors.white,
                      ),
                      SizedBox(height: 6.0.v),
                      Container(
                        width: double.infinity,
                        height: theme.textTheme.bodyMedium!.fontSize,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 24.0.adaptSize,
                    height: 24.0.adaptSize,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 10.0.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Container(
                  width: 150.v, // Adjust the width as needed
                  height: theme.textTheme.titleMedium!.fontSize,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h, bottom: 8.v),
                child: Container(
                  width: 200.v, // Adjust the width as needed
                  height: theme.textTheme.bodySmall!.fontSize,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),

  )
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,

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


}