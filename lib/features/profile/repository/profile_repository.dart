import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//----------------Fetching current  user profile data
class ProfileRepository extends BaseRepository {
  ProfileRepository({FirebaseFirestore? firestore});

  Future<ProfileModel?> fetchProfileData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      if (uid.isEmpty) return null;

      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(uid).get();

      if (snapshot.exists) {
        return ProfileModel.fromMap(snapshot.data()!);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
