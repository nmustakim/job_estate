
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';
import '../../models/job_model.dart';
import 'fetch_jobs_controller.dart';

final publishJobProvider =
    StateNotifierProvider<PublishJobController, BaseState>(
  (ref) => PublishJobController(ref: ref),
);

class PublishJobController extends StateNotifier<BaseState> {
  PublishJobController({required this.ref}) : super(const InitialState());

  final Ref? ref;

  Future<void> publishJob(Job job) async {
    print("Loading");
    try {
      state = const LoadingState();
      print("Loading");

      final DocumentReference docRef =
          FirebaseFirestore.instance.collection('Jobs').doc();

      job = job.copyWith(id: docRef.id);

      await docRef
          .set(job.toJson())
          .then((value) => ref!.read(jobsProvider.notifier).fetchJobs());

      state = PublishJobSuccessState();
      print("Success");
    } catch (error, stackTrace) {
      print('publishJob() error = $error');
      print(stackTrace);

      state = ErrorState(message: error.toString());
      toast("Error adding jobs");
    } finally {
      state = InitialState();
    }
  }
}
