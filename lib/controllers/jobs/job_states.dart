import 'package:job_estate/core/states/base_states.dart';

import '../../models/job_model.dart';

class FetchJobsSuccessState extends SuccessState{
List <Job> jobsList;
FetchJobsSuccessState(this.jobsList);
}

class AddJobsSuccessState extends SuccessState{

  AddJobsSuccessState();
}

class RemoveJobsSuccessState extends SuccessState{

 RemoveJobsSuccessState();
}