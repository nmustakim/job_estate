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

  Future<void> addUserToFirestore({
    required User user,
    required String fullName,
    String? phoneNumber,
    String? resumeUrl,
    String? profileImageUrl,
    String? address,
    String? city,
    String? state,
    String? country,
    String? gender,
    String? userType,
    String? birthDate,
    List<String>? skills,
    String? bio,
    List<Experience>? experiences,
    List<Education>? educations,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'userId': user.uid,
        'email': user.email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'resumeUrl': resumeUrl,
        'profileImageUrl': profileImageUrl,
        'address': address,
        'userType': userType,
        'city': city,
        'state': state,
        'gender':gender,
        'birthDate':birthDate,
        'country': country,
        'skills': skills,
        'bio': bio,
        'experiences': experiences?.map((exp) => exp.toJson()).toList(),
        'educations': educations?.map((edu) => edu.toJson()).toList(),
      });
    } catch (e) {
      toast("Error adding user details to Firestore");
      print("Error adding user details to Firestore: $e");
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updatedFields) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        state = LoadingState();
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .update(updatedFields);
        state = UpdateUserProfileSuccessState();
      } catch (error) {
        state = ErrorState(message: error.toString());
        print('Failed to update user profile: $error');
        throw Exception('Failed to update user profile');
      }
    }
  }
}
