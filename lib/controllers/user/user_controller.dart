import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_estate/controllers/user/userStates.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';

import '../../models/user_model.dart';

final userProvider = StateNotifierProvider<UserController, BaseState>(
      (ref) => UserController(ref: ref),
);

class UserController extends StateNotifier<BaseState> {
  final Ref? ref;
  UserController({this.ref}) : super(const InitialState());

  UserModel? user;

  Future<void> fetchUser() async {
    try {
      state = LoadingState();

      final String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null && userId.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('Users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          print("user exist");
          user = UserModel.fromJson(userDoc.data()!);
          state = FetchUserSuccessState(user!);
        } else {
          state = ErrorState(message: 'User not found');
          toast("User not found");
        }
      } else {
        state = ErrorState(message: 'User not authenticated');
        toast("User not authenticated");
      }
    } catch (error, stackTrace) {
      state = ErrorState(message: error.toString());
      toast("Error fetching user");
    }
  }
}
