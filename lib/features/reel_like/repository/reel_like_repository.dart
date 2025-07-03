import 'package:afriqueen/features/reel_like/model/reel_like_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ReelLikeRepository extends BaseRepository {
  ReelLikeRepository({FirebaseFirestore? firestore});

  //--------------------------adding reelLike--------------------------
  Future<void> addReelLike(String reelLikeId) async {
    final userDocId = currentUserId;

    final reelLikeDocRef = firestore
        .collection('users')
        .doc(userDocId)
        .collection('reelLike')
        .doc('main');

    final docSnapshot = await reelLikeDocRef.get();

    if (!docSnapshot.exists) {
      await reelLikeDocRef.set({
        'id': userDocId,
        'reelLikeId': [reelLikeId],
      });
    } else {
      await reelLikeDocRef.update({
        'reelLikeId': FieldValue.arrayUnion([reelLikeId]),
      });
    }
  }

  //-----------------removing reelLike--------------------------
  Future<void> removeReelLike(String reelLikeId) async {
    final userDocId = currentUserId;

    final reelLikeDocRef = firestore
        .collection('users')
        .doc(userDocId)
        .collection('reelLike')
        .doc('main');

    final docSnapshot = await reelLikeDocRef.get();

    if (!docSnapshot.exists) return;

    await reelLikeDocRef.update({
      'reelLikeId': FieldValue.arrayRemove([reelLikeId]),
    });

    final updatedDoc = await reelLikeDocRef.get();
    final data = updatedDoc.data();

    if (data != null) {
      final List<dynamic>? reelLikeIds = data['reelLikeId'];
      if (reelLikeIds == null || reelLikeIds.isEmpty) {
        await reelLikeDocRef.delete();
      }
    }
  }

  //-----------------fetching reelLikes--------------------------
  Future<ReelLikeModel?> fetchReelLikes() async {
    debugPrint("currentUserId : $currentUserId");

    final userDocId = currentUserId;

    final reelLikeDocRef = firestore
        .collection('users')
        .doc(userDocId)
        .collection('reelLike')
        .doc('main');

    final docSnapshot = await reelLikeDocRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) return null;

    return ReelLikeModel.fromMap(docSnapshot.data()!);
  }
}
