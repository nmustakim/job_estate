import 'package:job_estate/core/states/base_states.dart';

import '../../models/job_model.dart';
import '../../models/user_model.dart';

class FetchUserSuccessState extends SuccessState{
UserModel user;
  FetchUserSuccessState(this.user);
}
class UpdateUserProfileSuccessState extends SuccessState{

  UpdateUserProfileSuccessState();
}