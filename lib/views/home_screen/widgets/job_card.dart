import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/controllers/user/favorite_jobs_controller.dart';
import 'package:job_estate/controllers/user/user_controller.dart';

import '../../../models/job_model.dart';

class JobCard extends StatefulWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({
    Key? key,
    required this.job,
    required this.onTap,
  }) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
                      imagePath: widget.job.logo,
                      width: 50.0.adaptSize,
                      height: 50.0.adaptSize,
                    ),
                    SizedBox(width: 8.0.h),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 230.v,
                            child: Text(
                              widget.job.organizationName,
                              style: theme.textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 6.0.v),
                          Text(widget.job.location, style: theme.textTheme.bodyMedium),
                        ]),
                    Expanded(child: SizedBox()),
                    Consumer(builder: (context, ref, _) {
                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      final isFav = ref
                          .read(favoriteJobsProvider.notifier)
                          .favoriteJobIds
                          .contains(widget.job.id!);
                      return CustomImageView(
                        imagePath: isFav
                            ? ImageConstant.imgLoveIcon
                            : ImageConstant.imgLoveOutlined,
                        onTap: () async {

                          await ref
                              .read(favoriteJobsProvider.notifier)
                              .addToFavorites(userId, widget.job.id!);
                        },
                      );
                    })
                  ]),
              SizedBox(height: 10.0.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text(widget.job.title, style: theme.textTheme.titleMedium),
              ),
              SizedBox(height: 6.0.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h, bottom: 8.v),
                child: Text(
                  'Posted on: ${DateFormat('dd-MM-yyyy, hh:mm a').format(widget.job.postedDate)}',
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
