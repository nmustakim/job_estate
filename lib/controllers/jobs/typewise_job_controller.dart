import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/jobs/job_controller.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';
import '../../models/job_model.dart';

final typeWiseJobsProvider = StateNotifierProvider<TypeWiseJobsController, BaseState>(
      (ref) => TypeWiseJobsController(ref: ref),
);

class TypeWiseJobsController extends StateNotifier<BaseState> {
  final Ref? ref;
  TypeWiseJobsController({this.ref}) : super(const InitialState());


  List<Job> typeWiseJobs = [];


  Future<void> fetchTypeWiseJobs(String professionType) async {
    try {
      state = LoadingState();

      typeWiseJobs = await ref!.read(jobsProvider.notifier).jobList.where((job) => job.professionType==professionType).toList();
print(typeWiseJobs);
      state = FetchTypeWiseJobsSuccessState(typeWiseJobs);
    } catch (error, stackTrace) {
      print('Error = $error');
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error fetching jobs");
    }
  }





}
