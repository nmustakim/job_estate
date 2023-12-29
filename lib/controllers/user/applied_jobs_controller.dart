import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/jobs/job_controller.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';
import '../../models/job_model.dart';

final appliedJobsProvider = StateNotifierProvider<AppliedJobsController, BaseState>(
      (ref) => AppliedJobsController(ref: ref),
);

class AppliedJobsController extends StateNotifier<BaseState> {
  final Ref? ref;
  AppliedJobsController({this.ref}) : super(const InitialState());


  List<Job> appliedJobs = [];


  Future<void> fetchUserAppliedJobs(String userId) async {
    try {
      state = LoadingState();

      appliedJobs = ref!.read(jobsProvider.notifier).jobList.where((job) => job.applicants?.contains(userId) == true).toList();

      state = FetchUserAppliedJobsSuccessState(appliedJobs);
    } catch (error, stackTrace) {
      print('fetchUserAppliedJobs() error = $error');
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error fetching user's applied jobs");
    }
  }





}
