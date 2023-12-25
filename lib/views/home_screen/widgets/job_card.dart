import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_estate/app_export/app_export.dart';

import '../../../models/job_model.dart';

class JobCard extends StatelessWidget {
  final Job job;
    final VoidCallback onTap;

  const JobCard({
    Key? key,
    required this.job, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      width: 50.0.h,
                    height: 50.0.v,
                  ),
               
                   SizedBox(width: 8.0.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 230.v,
                        child: Text(
                          job.organizationName,
                          style: theme.textTheme.titleLarge,overflow: TextOverflow.ellipsis,
                        ),
                      ),
                         SizedBox(height: 6.0.v),
                      Text(
                        job.location,
                        style: theme.textTheme.bodyMedium
                      ),
                 
                  
                ]),
                Expanded(child: SizedBox()),
                     CustomImageView(imagePath: ImageConstant.imgLoveOutlined,onTap: (){},)
                ]
              ),
                      SizedBox(height: 10.0.v),
                        Padding(
                         padding:  EdgeInsets.only(left: 8.h),
                          child: Text(
                            job.title,
                            style:theme.textTheme.titleMedium
                          ),
                        ),
                      
                          SizedBox(height: 6.0.v),
                        Padding(
                          padding:  EdgeInsets.only(left: 8.h,bottom: 8.v),
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