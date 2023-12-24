import 'dart:io';

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
    try {
      state = const LoadingState();
      print("Loading");

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final DocumentReference documentReference = await FirebaseFirestore
            .instance
            .collection('Jobs')
            .add(job.toJson());

        final String docId = documentReference.id;
        job = job.copyWith(id: docId);

        await documentReference.update({'id': docId});
      });

      await ref!.read(jobsProvider.notifier).fetchJobs();

      state = PublishJobSuccessState();
      print("Success");
    } catch (error, stackTrace) {
      print('addJob() error = $error');
      print(stackTrace);

      state = ErrorState(message: error.toString());
      toast("Error adding jobs");
    }
    finally{
      state = InitialState();
    }
  }
}
