import 'package:flutter/material.dart';
import 'package:job_estate/views/home_screen/widgets/job_card_list.dart';
import 'package:job_estate/widgets/app_bar/custom_app_bar_job_list.dart';

import '../../models/job_model.dart';


class RecentJobsScreen extends StatelessWidget {
  const RecentJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForJobList(title: "Recent Jobs"),
      body: JobCardList(jobsList: []),
    );
  }
}