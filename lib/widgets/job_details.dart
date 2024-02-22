import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/controllers/user/applied_jobs_controller.dart';
import 'package:job_estate/controllers/user/user_controller.dart';
import 'package:job_estate/core/states/base_states.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar_job_list.dart';
import 'package:job_estate/widgets/custom_elevated_button.dart';

import '../controllers/jobs/job_controller.dart';
import '../models/job_model.dart';
import 'app_bar/appbar_leading_image.dart';
import 'app_bar/appbar_subtitle.dart';
import 'app_bar/custom_app_bar.dart';

class JobDetails extends StatelessWidget {
  final Job job;

  JobDetails({required this.job});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            leadingWidth: 50.h,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeftBlueGray300,
                margin: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 15.h),
                onTap: () {
                  Navigator.pop(context);
                }),
            height: 50.h,
            title: AppbarSubtitle(
                text: "Job details", margin: EdgeInsets.only(left: 12.w))),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 80.w,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(16),
                        child: CustomImageView(
                          imagePath: job.logo,
                          height: 50.h,
                          width: 50.w,
                        )),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.organizationName,
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 1.w,
                        ),
                        Text(
                          job.location,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.w),
                _buildHeader(context, title: "Job Summary"),
                SizedBox(height: 8.w),
                Text(
                  job.jobSummary ?? '',
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 20.w),
                _buildHeader(context, title: "Roles & Responsibilities"),
                SizedBox(height: 8.w),
                Wrap(
                  spacing: 6.0,
                  children: [
                    ...job.rolesAndResponsibilities.map(
                      (role) => Text(
                        role,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.w),
                _buildHeader(context, title: "Education"),
                SizedBox(height: 8.w),
                Text(
                  job.education,
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 20.w),
                _buildHeader(context, title: "Required Skills"),
                SizedBox(height: 8.w),
                Wrap(
                  spacing: 6.0, // Adjust spacing as needed
                  children: [
                    ...job.skills.map((skill) => Chip(
                          label: Text(
                            skill,
                            style: theme.textTheme.bodyMedium,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Consumer(builder: (context, ref, _) {
                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  final applyState = ref.watch(appliedJobsProvider);
                  return CustomElevatedButton(
                    buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor:job.applicants!.contains(userId)|| applyState is LoadingState
                            ? Colors.grey : theme.primaryColor
                    ),
                    text:job.applicants!.contains(userId)?"Already applied":applyState is LoadingState ?"Please wait...":"Apply",
                    onPressed: () {

                      job.applicants!.contains(userId)?null: ref.read(appliedJobsProvider.notifier).applyForJob(job.id!, userId);

                    },
                  );
                }),
                SizedBox(
                  height: 12.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required String title,
  }) {
    return Text(title, style: theme.textTheme.titleMedium);
  }
}
