import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        'gender': gender,
        'birthDate': birthDate,
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

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      final Reference storageReference =
      FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<void> updateProfilePicture(BuildContext context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        final File imageFile = File(pickedImage.path);

        final imageUrl = await uploadImageToStorage(imageFile);

        await updateProfileField('profileImageUrl', imageUrl, context);
      }
    } catch (e) {
      toast('Failed to update profile picture');
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> updateProfileField(String fieldName, String fieldValue,
      BuildContext context) async {
    try {
      await ref
      !.read(userProvider.notifier)
          .updateUserProfile({fieldName: fieldValue}).then(
              (value) => ref!.read(userProvider.notifier).fetchUser());
      toast('Profile updated successfully');
    } catch (error) {
      toast('Failed to update profile');
    }
  }



  Future<void> applyForJob(String jobId, String userId) async {
    try {
      state = LoadingState();
      DocumentReference jobRef = _firestore.collection('Jobs').doc(jobId);

      await jobRef.update({
        'applicants': FieldValue.arrayUnion([userId]),
      });
      toast('Successfully applied to the job');
      state = ApplyJobSuccessState();
    } catch (error) {
      state = ErrorState(message: error.toString());
      toast('Failed to apply');
      ;
    }
  }


}