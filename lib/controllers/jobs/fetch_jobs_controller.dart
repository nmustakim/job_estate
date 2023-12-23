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

  Future<void> fetchJobs(
      {String? location, String? employmentType, int? salary}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Jobs').get();

      jobList =
          querySnapshot.docs.map((doc) => Job.fromJson(doc.data())).toList();

      state = FetchJobsSuccessState(jobList);
    } catch (error, stackTrace) {
      print('fetchJobs() error = $error');
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error fetching jobs");
    }
  }

  Future<void> addJob(Job job) async {
    try {
      await FirebaseFirestore.instance.collection('Jobs').add(job.toJson());
      await fetchJobs();
    } catch (error, stackTrace) {
      print('addJob() error = $error');
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error adding jobs");
    }
  }

  Future<void> removeJob(String jobId) async {
    try {
      await FirebaseFirestore.instance.collection('Jobs').doc(jobId).delete();

      await fetchJobs();
    } catch (error, stackTrace) {
      print('removeJob() error = $error');
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error removing jobs");
    }
  }
}
