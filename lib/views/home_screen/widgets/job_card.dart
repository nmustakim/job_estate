import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/controllers/user/favorite_jobs_controller.dart';
import 'package:job_estate/controllers/user/user_controller.dart';

import '../../../models/job_model.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final bool onFavScreen;
  final VoidCallback onTap;

  const JobCard({
    Key? key,
    required this.job,
    required this.onTap, required this.onFavScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return InkWell(
      onTap: onTap,
      child: Card(
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
                  CustomImageView(
                    imagePath: job.logo,
                    width: 50.0.w,
                    height: 50.0.h,
                  ),
                  SizedBox(width: 8.0.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 230.w,
                        child: Text(
                          job.organizationName,
                          style: theme.textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 6.0.h),
                      Text(job.location, style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  Expanded(child: SizedBox()),
              Consumer(builder: (context,ref,_) {
                final favJobs = ref.watch(favoriteJobsProvider);

                final isFav = ref
                    .read(favoriteJobsProvider.notifier)
                    .favoriteJobIds
                    .contains(job.id!);

                return InkWell(
                  onTap: () async {
                    final favController = ref.read(
                        favoriteJobsProvider.notifier);
                    if (isFav) {
                      await favController.removeFromFavorites(userId, job.id!,);
                    } else {
                      await favController.addToFavorites(userId, job.id!);
                    }
                  },
                  child: CustomImageView(
                    imagePath: isFav
                        ? ImageConstant.imgLoveIcon
                        : ImageConstant.imgLoveOutlined,
                  ),

                );
              }
              )

                ],
              ),
              SizedBox(height: 10.0.h),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text(job.title, style: theme.textTheme.titleMedium),
              ),
              SizedBox(height: 6.0.h),
              Padding(
                padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
                child: Text(
                  'Posted on: ${DateFormat('dd-MM-yyyy, hh:mm a').format(job.postedDate)}',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
