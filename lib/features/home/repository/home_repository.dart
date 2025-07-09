import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//----------------Fetching current   profile data of all user
class HomeRepository extends BaseRepository {
  HomeRepository({FirebaseFirestore? firestore}) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

  Future<List<ProfileModel>> fetchAllExceptCurrentUser() async {
    try {
      if (currentUserId.isEmpty) return [];

      final snapshot = await firestore
          .collection('users')
          .where('id', isNotEqualTo: currentUserId)
          .get();

      return snapshot.docs
          .map((doc) => ProfileModel.fromJson(
                doc.data(),
                // include doc ID if needed inside model
              ))
          .toList();
      // Exclude current user by doc ID
    } catch (e) {
      rethrow;
    }
  }
}
