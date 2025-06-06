import 'package:afriqueen/features/like/model/like_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class LikeRepository extends BaseRepository {
  LikeRepository({FirebaseFirestore? firestore});
  //--------------------------adding favourite--------------------------
  Future<void> addLike(String likeId) async {
    // Find the user document where 'id' == Firebase UID
    final userQuery = await firestore
        .collection('user')
        .where('id', isEqualTo: currentUserId)
        .get();

    if (userQuery.docs.isEmpty) return; // User not found

    final userDocId = userQuery.docs.first.id;

    // Use fixed document 'main' under favourite subcollection
    final favouriteDocRef = firestore
        .collection('user')
        .doc(userDocId)
        .collection('like')
        .doc('main');

    final docSnapshot = await favouriteDocRef.get();

    if (!docSnapshot.exists) {
      await favouriteDocRef.set({
        'id': currentUserId,
        'likeId': [likeId],
      });
    } else {
      await favouriteDocRef.update({
        'likeId': FieldValue.arrayUnion([likeId]),
      });
    }
  }

  //-----------------deleting block user or removing  favourite
  Future<void> removeLike(String likeId) async {
    // Find the correct user document using 'id' == currentUserId
    final userQuery = await firestore
        .collection('user')
        .where('id', isEqualTo: currentUserId)
        .get();

    if (userQuery.docs.isEmpty) return; // User not found

    final userDocId = userQuery.docs.first.id;

    final favouriteDocRef = firestore
        .collection('user')
        .doc(userDocId)
        .collection('like')
        .doc('main');

    final docSnapshot = await favouriteDocRef.get();

    if (!docSnapshot.exists) return;

    // Remove the likeId from the list
    await favouriteDocRef.update({
      'likeId': FieldValue.arrayRemove([likeId]),
    });

    // Re-check the updated document to see if list is now empty
    final updatedDoc = await favouriteDocRef.get();
    final data = updatedDoc.data();

    if (data != null) {
      final List<dynamic>? favIds = data['likeId'];
      if (favIds == null || favIds.isEmpty) {
        // Delete the 'main' document if no more blocked IDs
        await favouriteDocRef.delete();
      }
    }
  }

  Future<LikeModel?> fetchLikes() async {
    debugPrint("currentUserId : ${currentUserId}");
    final userQuery = await firestore
        .collection('user')
        .where('id', isEqualTo: currentUserId)
        .get();

    if (userQuery.docs.isEmpty) return null;

    final userDocId = userQuery.docs.first.id;

    final favouriteDocRef = firestore
        .collection('user')
        .doc(userDocId)
        .collection('like')
        .doc('main');

    final docSnapshot = await favouriteDocRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) return null;

    return LikeModel.fromMap(docSnapshot.data()!);
  }
}
