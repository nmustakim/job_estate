import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';

import 'job_controller.dart';

final RemoveJobsProvider =
StateNotifierProvider<RemoveJobsController, BaseState>(
      (ref) => RemoveJobsController(ref: ref),
);

class RemoveJobsController extends StateNotifier<BaseState> {
  final Ref? ref;
  RemoveJobsController({this.ref}) : super(const InitialState());



  Future<void> removeJob(String jobId) async {
    try {
      state = const LoadingState();
      await FirebaseFirestore.instance.collection('Jobs').doc(jobId).delete();
      await ref!.read(jobsProvider.notifier).fetchJobs();
      state =  RemoveJobsSuccessState();
    } catch (error, stackTrace) {
      print('removeJob() error = $error');
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error removing jobs");
    }
  }
}