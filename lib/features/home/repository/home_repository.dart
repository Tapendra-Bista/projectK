import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//----------------Fetching current   profile data of all user
class HomeRepository extends BaseRepository {
  HomeRepository({FirebaseFirestore? firestore});

  Future<List<ProfileModel>> fetchAllExceptCurrentUser() async {
    try {
      if (currentUserId.isEmpty) return [];

      final snapshot = await firestore.collection('users').get();

      return snapshot.docs
          .where((doc) =>
              doc.id != currentUserId) // Exclude current user by doc ID
          .map((doc) => ProfileModel.fromMap(
                doc.data(),
                // include doc ID if needed inside model
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
