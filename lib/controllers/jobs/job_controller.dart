import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';
import '../../models/job_model.dart';

final jobsProvider = StateNotifierProvider<JobsController, BaseState>(
  (ref) => JobsController(ref: ref),
);

class JobsController extends StateNotifier<BaseState> {
  final Ref? ref;
  JobsController({this.ref}) : super(const InitialState());

  List<Job> jobList = [];


  Future<void> fetchJobs() async {
    try {
      state = LoadingState();
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Jobs').get();

      jobList =
          querySnapshot.docs.map((doc) => Job.fromJson(doc.data())).toList();
      print("JobsList:$jobList");
      state = FetchJobsSuccessState(jobList);
    } catch (error, stackTrace) {
      print('fetchJobs() error = $error');
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error fetching jobs");
    }
  }

  List<Job> getJobsPostedLast7Days() {
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(Duration(days: 7));

    return jobList
        .where((job) => job.postedDate.isAfter(sevenDaysAgo))
        .toList();
  }

  List<Job> getTodayJobs() {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    return jobList
        .where((job) => job.postedDate.isAtSameMomentAs(today))
        .toList();
  }

  String getJobsPostedLast7DaysCount() {
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(Duration(days: 7));

    return jobList
        .where((job) => job.postedDate.isAfter(sevenDaysAgo))
        .length.toString();
  }

  String getTodayJobsCount() {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    return jobList
        .where((job) => job.postedDate.isAtSameMomentAs(today))
        .length.toString();
  }







}
