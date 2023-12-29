import 'package:job_estate/core/states/base_states.dart';

import '../../models/job_model.dart';

class FetchJobsSuccessState extends SuccessState{
List <Job> jobsList;
FetchJobsSuccessState(this.jobsList);
}

class FetchUserAppliedJobsSuccessState extends SuccessState{
  List <Job> appliedJobs;
  FetchUserAppliedJobsSuccessState(this.appliedJobs);
}

class FetchTypeWiseJobsSuccessState extends SuccessState{
  List <Job> typeWiseJobs;
  FetchTypeWiseJobsSuccessState(this.typeWiseJobs);
}

class PublishJobSuccessState extends SuccessState{

  PublishJobSuccessState();
}

class RemoveJobsSuccessState extends SuccessState{

 RemoveJobsSuccessState();
}

class ApplyJobSuccessState extends SuccessState{

  ApplyJobSuccessState();
}
