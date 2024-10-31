import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/controllers/auth/auth_states.dart';
import 'package:job_estate/controllers/jobs/job_controller.dart';
import 'package:job_estate/controllers/user/user_controller.dart';
import 'package:job_estate/routes/app_routes.dart';
import 'package:job_estate/services/navigation_service.dart';

import '../../core/states/base_states.dart';
import '../../models/user_model.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authenticationProvider.notifier).authStateChange;
});

final authenticationProvider = StateNotifierProvider<AuthenticationController, BaseState>((ref) {
  return AuthenticationController(
    ref: ref,
    firebaseAuth: ref.read(firebaseAuthProvider),
  );
});

class AuthenticationController extends StateNotifier<BaseState> {
  AuthenticationController({required this.ref, required this.firebaseAuth})
      : super(InitialState());

  final FirebaseAuth firebaseAuth;
  final Ref ref;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  static StateNotifierProvider<AuthenticationController, BaseState>
  get controller => authenticationProvider;

  Future<void> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      state = LoadingState();
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (firebaseAuth.currentUser != null) {
        state = LoginSuccessState();
        FocusScope.of(context).unfocus(); // Hide keyboard

        await ref.read(jobsProvider.notifier).fetchJobs().then((_) {
          NavigationService.navigateAndRemoveUntil(AppRoutes.homeContainerScreen);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful")),
        );
      } else {
        state = ErrorState(message: "Something went wrong");
      }
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.message ?? 'Login error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login error')),
      );
    }
  }

  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String? resumeUrl,
    String? profileImageUrl,
    String? address,
    String? city,
    String? userType,
    String? gender,
    String? district,
    String? country,
    List<String>? skills,
    String? bio,
    String? educationLevel,
    List<Experience>? experiences,
    List<Education>? educations,
  }) async {
    try {
      state = LoadingState();

      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        try {
          await ref.read(userProvider.notifier).addUserToFirestore(
            user: user,
            fullName: fullName,
            phoneNumber: phoneNumber,
            resumeUrl: resumeUrl,
            profileImageUrl: profileImageUrl,
            address: address,
            city: city,
            userType: userType,
            gender: gender,
            state: district,
            country: country,
            skills: skills,
            bio: bio,
            experiences: experiences,
            educations: educations,
          );

          state = RegisterSuccessState();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Sign up successful")),
          );

          await ref.read(userProvider.notifier).fetchUser();
          await ref.read(jobsProvider.notifier).fetchJobs().then((_) {
            NavigationService.navigateAndRemoveUntil(AppRoutes.homeContainerScreen);
          });
        } catch (e) {
          state = ErrorState(message: 'Failed to save user data');
        }
      } else {
        state = ErrorState(message: "Sign-up failed");
      }
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.message ?? 'Sign-up error');
    }
  }

  Future<void> signOut() async => await firebaseAuth.signOut();
}
