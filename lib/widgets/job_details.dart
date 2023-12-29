import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/controllers/user/user_controller.dart';
import 'package:job_estate/core/states/base_states.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar_job_list.dart';
import 'package:job_estate/widgets/custom_elevated_button.dart';

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
            leadingWidth: 50.v,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeftBlueGray300,
                margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
                onTap: () {
                  Navigator.pop(context);
                }),
            height: 50.v,
            title: AppbarSubtitle(
                text: "Job details", margin: EdgeInsets.only(left: 12.h))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 80.h,
                      width: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(16),
                      child: CustomImageView(
                        imagePath: job.logo,
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                      )),
                  SizedBox(
                    width: 20.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.organizationName,
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        job.location,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h),
              _buildHeader(context, title: "Job Summary"),
              SizedBox(height: 8.h),
              Text(
                job.jobSummary ?? '',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 20.h),
              _buildHeader(context, title: "Roles & Responsibilities"),
              SizedBox(height: 8.h),
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
              SizedBox(height: 20.h),
              _buildHeader(context, title: "Education"),
              SizedBox(height: 8.h),
              Text(
                job.education,
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 20.h),
              _buildHeader(context, title: "Required Skills"),
              SizedBox(height: 8.h),
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
                final applyState = ref.watch(userProvider);
                return CustomElevatedButton(
                  buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: applyState is LoadingState
                          ? Colors.grey : theme.primaryColor
                  ),
                  text:applyState is LoadingState ?"Please wait...":"Apply",
                  onPressed: () {
                    final userId = FirebaseAuth.instance.currentUser!.uid;
                    ref.read(userProvider.notifier).applyForJob(job.id!, userId);
                  },
                );
              }),
              SizedBox(
                height: 12.v,
              )
            ],
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
