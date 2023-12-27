import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/controllers/auth/auth_states.dart';
import 'package:job_estate/controllers/jobs/fetch_jobs_controller.dart';
import 'package:job_estate/routes/app_routes.dart';
import 'package:job_estate/services/navigation_service.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';
import '../../models/user_model.dart';


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authenticationProvider.notifier).authStateChange;
});

final authenticationProvider = StateNotifierProvider(
  (ref) => AuthenticationController(
    ref: ref,
    firebaseAuth: ref.read(firebaseAuthProvider),
  ),
);

class AuthenticationController extends StateNotifier<BaseState> {
  AuthenticationController({required this.ref, required this.firebaseAuth})
      : super(InitialState());

  final FirebaseAuth firebaseAuth;
  final Ref ref;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  static StateNotifierProvider<AuthenticationController, dynamic>
      get controller => authenticationProvider;

  Future<void> signIn(context,
      {required String email, required String password}) async {
    try {
      state = LoadingState();
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (firebaseAuth.currentUser != null) {
        state = LoginSuccessState();
        hideKeyboard(context);
        ref.read(jobsProvider.notifier).fetchJobs().then((value) =>
            NavigationService.navigateAndRemoveUntil(
                AppRoutes.homeContainerScreen));
        toast("Login successful");
      } else {
        state = ErrorState(message: "Something went wrong");
        toast("Login failed");
      }
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.message ?? '');
      toast(e.message);
    } finally {
      state = InitialState();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String? resumeUrl,
    String? profileImageUrl,
    String? address,
    String? city,
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

      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        await addUserToFirestore(
          user: user,
          fullName: fullName,
          phoneNumber: phoneNumber,
          resumeUrl: resumeUrl,
          profileImageUrl: profileImageUrl,
          address: address,
          city: city,
          state: district,
          country: country,
          skills: skills,
          bio: bio,
          experiences: experiences,
          educations: educations,
        );

        state = RegisterSuccessState();
        toast("Sign up successful");
        ref.read(jobsProvider.notifier).fetchJobs().then((value) =>
            NavigationService.navigateAndRemoveUntil(
                AppRoutes.homeContainerScreen));
      }
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.message ?? '');
    } finally {
      state = InitialState();
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
        'city': city,
        'state': state,
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

  Future<void> signOut() async => await firebaseAuth.signOut();
}
