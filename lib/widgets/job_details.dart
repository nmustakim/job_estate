import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar_job_list.dart';
import 'package:job_estate/widgets/custom_elevated_button.dart';

import '../models/job_model.dart';

class JobDetails extends StatelessWidget {
  final Job job;

  JobDetails({required this.job});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarForJobList(title: 'Job Details',),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height:80.h,width: 80.h,
              
                    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2),borderRadius: BorderRadius.circular(12),
                    ),
                    padding:EdgeInsets.all(16),child: CustomImageView(imagePath: job.logo,height:50.adaptSize,width: 50.adaptSize,)),
                 SizedBox(width: 20.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.organizationName,
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 1.h,),
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

         
              SizedBox(height: 10),
              Text(
                job.jobSummary ?? '',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              _buildHeader(context, title: "Roles & Responsibilities"),
        
              SizedBox(height: 10),
              ListView.builder(
                itemCount: job.rolesAndResponsibilities.length,
                itemBuilder: (context, index) {
                  return Text(
                    job.rolesAndResponsibilities[index],
                    style: theme.textTheme.bodyMedium,
                  );
                },
              ),
                 SizedBox(height: 10),
                    _buildHeader(context, title: "Requirements"),
              SizedBox(height: 20),
              CustomElevatedButton(
                text: "Apply",
                onPressed: () {},
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
    return Text(title,
        style: theme.textTheme.titleMedium);
  }
}
