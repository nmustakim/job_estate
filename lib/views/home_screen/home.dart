import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';
import 'package:job_estate/controllers/jobs/job_controller.dart';
import 'package:job_estate/controllers/jobs/typewise_job_controller.dart';
import 'package:job_estate/views/home_screen/widgets/banner_widget.dart';
import 'package:job_estate/views/home_screen/widgets/job_card_list.dart';
import 'package:job_estate/views/typewise_jobs_screen/typewise_jobs_screen.dart';

import '../../widgets/app_bar/appbar_title_edittext.dart';

import '../../widgets/job_details.dart';
import '../../models/job_model.dart';
import 'widgets/top_professions_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';

import 'package:job_estate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar.dart';

class Home extends ConsumerStatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  TextEditingController searchController = TextEditingController();

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final jobsState = ref.watch(jobsProvider);
    final jobs = jobsState is FetchJobsSuccessState ? jobsState.jobsList:[];
    print(jobs);
    return SafeArea(
        child: Scaffold(
            appBar:  CustomAppBar(
                title: AppbarTitleEdittext(
                    margin: EdgeInsets.only(left: 16.h, top: 8.h),
                    hintText: "Search jobs",
                    controller: searchController),
                actions: [
                  AppbarTrailingImage(
                      imagePath: ImageConstant.imgMicIcon, margin: EdgeInsets.all(16.h))
                ]),
            body: SizedBox(
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 27.v),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       Center(child: BannerWidget(totalJobs: jobs.length.toString(), newJobs: ref.read(jobsProvider.notifier).getJobsPostedLast7DaysCount(), postedToday: ref.read(jobsProvider.notifier).getTodayJobsCount())),
                          SizedBox(height: 25.v),
                          _buildHeader(
                            context,
                            title: "All professions",
                          ),
                          SizedBox(height: 10.v),
                          _buildTopProfessions(context),
                          SizedBox(height: 16.v),
                          _buildHeader(
                            context,
                            title: "Recent jobs",
                            seeMoreLink: "View all",
                          ),
                          JobCardList(
                            jobsList: jobs,
                            isHome: true,
                          )
                        ])))));
  }



  Widget _buildTopProfessions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: SizedBox(
          height: 140.v,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(width: 16.h);
              },
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: index == 3 ? 16 : 0),
                  child: Consumer(
                    builder: (context,ref,_) {
                      final title = index == 0
                          ? "Software Engineering"
                          : index == 1
                          ? "Design"
                          : index == 2
                          ? "Engineering"
                          : "Accounting";
                      return TopProfessionItemWidget(
                          title: title,
                          icon: index == 0
                              ? ImageConstant.imgProgramming
                              : index == 1
                              ? ImageConstant.imgDesign
                              : index == 2
                              ? ImageConstant.imgEngineering
                              : ImageConstant.imgAccounting,
                          onTap: ()async {
                            await ref.read(typeWiseJobsProvider.notifier).fetchTypeWiseJobs(title);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TypeWiseJobsScreen(title: index == 0
                                            ? "Software Engineering"
                                            : index == 1
                                            ? "Design"
                                            : index == 2
                                            ? "Engineering"
                                            : "Accounting")));
                          }
                      );
                    }
                  ),
                );
              })),
    );
  }



  Widget _buildHeader(
    BuildContext context, {
    required String title,
    String? seeMoreLink,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title,
            style: theme.textTheme.titleLarge!
                .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1))),
        InkWell(
            onTap: () {
              onTapViewAll(context);
            },
            child: Text(seeMoreLink ?? "",
                style: CustomTextStyles.titleSmallPrimary
                    .copyWith(color: theme.colorScheme.primary.withOpacity(1))))
      ]),
    );
  }

  onTapSearch(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.searchScreen);
  }

  onTapViewAll(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recentJobsScreen);
  }

  onTapSeeMore(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recentJobsScreen);
  }


  onTapJobCard(BuildContext context, Job job) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDetails(
             job: job,)));
  }
}
