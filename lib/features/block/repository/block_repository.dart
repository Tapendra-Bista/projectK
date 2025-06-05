import 'package:afriqueen/features/block/model/block_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class BlockRepository {
  final FirebaseFirestore _firebaseFirestore;

  BlockRepository({FirebaseFirestore? firestore})
    : _firebaseFirestore = firestore ?? FirebaseFirestore.instance;
  //--------------------------adding block--------------------------
  Future<void> addblock(String blockId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final currentUserId = currentUser.uid;

    // Find the user document where 'id' == Firebase UID
    final userQuery = await _firebaseFirestore
        .collection('user')
        .where('id', isEqualTo: currentUserId)
        .get();

    if (userQuery.docs.isEmpty) return; // User not found

    final userDocId = userQuery.docs.first.id;

    // Use fixed document 'main' under block subcollection
    final blockDocRef = _firebaseFirestore
        .collection('user')
        .doc(userDocId)
        .collection('block')
        .doc('main');

    final docSnapshot = await blockDocRef.get();

    if (!docSnapshot.exists) {
      await blockDocRef.set({
        'id': currentUserId,
        'blockId': [blockId],
      });
    } else {
      await blockDocRef.update({
        'blockId': FieldValue.arrayUnion([blockId]),
      });
    }
  }

  //-----------------deleting block user or removing  block
  Future<void> removeblock(String blockId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final currentUserId = currentUser.uid;

    // Find the correct user document using 'id' == currentUserId
    final userQuery = await _firebaseFirestore
        .collection('user')
        .where('id', isEqualTo: currentUserId)
        .get();

    if (userQuery.docs.isEmpty) return; // User not found

    final userDocId = userQuery.docs.first.id;

    final blockDocRef = _firebaseFirestore
        .collection('user')
        .doc(userDocId)
        .collection('block')
        .doc('main');

    final docSnapshot = await blockDocRef.get();

    if (!docSnapshot.exists) return;

    // Remove the blockId from the list
    await blockDocRef.update({
      'blockId': FieldValue.arrayRemove([blockId]),
    });

    // Re-check the updated document to see if list is now empty
    final updatedDoc = await blockDocRef.get();
    final data = updatedDoc.data();

    if (data != null) {
      final List<dynamic>? favIds = data['blockId'];
      if (favIds == null || favIds.isEmpty) {
        // Delete the 'main' document if no more blocked IDs
        await blockDocRef.delete();
      }
    }
  }

  Future<BlockModel?> fetchblocks() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return null;

    final currentUserId = currentUser.uid;
    debugPrint("currentUserId : ${currentUserId}");
    final userQuery = await _firebaseFirestore
        .collection('user')
        .where('id', isEqualTo: currentUserId)
        .get();

    if (userQuery.docs.isEmpty) return null;

    final userDocId = userQuery.docs.first.id;

    final blockDocRef = _firebaseFirestore
        .collection('user')
        .doc(userDocId)
        .collection('block')
        .doc('main');

    final docSnapshot = await blockDocRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) return null;

    return BlockModel.fromMap(docSnapshot.data()!);
  }
}
