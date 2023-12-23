import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/controllers/auth/auth_states.dart';
import 'package:job_estate/controllers/jobs/fetch_jobs_controller.dart';
import 'package:job_estate/routes/app_routes.dart';
import 'package:job_estate/services/navigation_service.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';

// Define a provider for FirebaseAuth
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

  static StateNotifierProvider<AuthenticationController, dynamic> get controller =>
      authenticationProvider;

  Future<void> signIn(context,{required String email, required String password}) async {
    try {
      state = LoadingState();
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (firebaseAuth.currentUser != null) {
        state = LoginSuccessState();
        hideKeyboard(context);
         ref.read(jobsProvider.notifier).fetchJobs().then((value) =>   NavigationService.navigateAndRemoveUntil(AppRoutes.homeContainerScreen));

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

  Future<void> signUp({required String email, required String password}) async {
    try {
      state = LoadingState();
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.message ?? '');
    } finally {
      state = InitialState();
    }
  }

  Future<void> signOut() async => await firebaseAuth.signOut();
}
