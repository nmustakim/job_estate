import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../widgets/job_details.dart';
import '../../../models/job_model.dart';
import 'job_card.dart';



class JobCardList extends StatefulWidget {
  final List<dynamic> jobsList;
  final bool? isHome;
  const JobCardList({Key? key, required this.jobsList, this.isHome})
      : super(key: key);

  @override
  _JobCardListState createState() => _JobCardListState();
}

class _JobCardListState extends State<JobCardList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: ListView.builder(
        physics: widget.isHome == true
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.jobsList.length,
        itemBuilder: (context, index) {
          final job = widget.jobsList[index];
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: JobCard(
              job: job,
              onFavScreen: false,
              onTap: () => _onTapProfessionIcon(context, job),
            ),
          );
        },
      ),
    );
  }

  _onTapProfessionIcon(BuildContext context, Job job) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDetails(
                  job: job,
                )));
  }
}
