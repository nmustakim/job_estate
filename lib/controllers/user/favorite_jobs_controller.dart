import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/jobs/job_controller.dart';
import 'package:job_estate/controllers/jobs/job_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/states/base_states.dart';
import '../../models/job_model.dart';

final favoriteJobsProvider =
    StateNotifierProvider<FavoriteJobsController, BaseState>(
  (ref) => FavoriteJobsController(ref: ref),
);

class FavoriteJobsController extends StateNotifier<BaseState> {
  final Ref? ref;
  FavoriteJobsController({this.ref}) : super(const InitialState());

  List<Job> favoriteJobs = [];
  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');
  Set<String> favoriteJobIds = {};

  Future<void> fetchFavorites(String userId) async {
    try {
      state = LoadingState();
      favoriteJobIds.clear();

      DocumentSnapshot<Map<String, dynamic>> userFavorites =
          await favoritesCollection.doc(userId).get()
              as DocumentSnapshot<Map<String, dynamic>>;

      if (userFavorites.exists) {
        final data = userFavorites.data();
        if (data != null) {
          favoriteJobIds.addAll(List<String>.from(data['favoriteJobIds']));
          state = FetchUserFavoriteJobsSuccessState(favoriteJobs);
        }
      }
    } catch (error, stackTrace) {
      print(stackTrace);
      state = ErrorState(message: error.toString());
      toast("Error fetching favorite jobs");
    }
  }
  Future<void> addToFavorites(String userId, String jobId) async {
    try {

      favoriteJobIds.add(jobId);

      await updateFavoritesInFirebase(userId);
    } catch (error) {
      print('addToFavorites() error = $error');
      toast("Error adding to favorites");
    }
  }

  Future<void> updateFavoritesInFirebase(String userId) async {
    try {

      await favoritesCollection
          .doc(userId)
          .set({'favoriteJobIds': favoriteJobIds.toList()});
    } catch (error) {
      print('updateFavoritesInFirebase() error = $error');
    }
  }
}
