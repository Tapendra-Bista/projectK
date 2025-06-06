import 'package:afriqueen/features/archive/model/archive_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
//-------------------------Archive Repository---------------------------
class ArchiveRepository extends BaseRepository {
  final FirebaseFirestore firestore;

  ArchiveRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;
  //--------------------------adding archive--------------------------
  Future<void> addArchive(String archiveId) async {
    // Find the user document where 'id' == Firebase UID
    final userQuery = await firestore
        .collection('user')
        .where('id', isEqualTo: currentUserId)
        .get();

    if (userQuery.docs.isEmpty) return; // User not found

    final userDocId = userQuery.docs.first.id;

    // Use fixed document 'main' under archive subcollection
    final favouriteDocRef = firestore
        .collection('user')
        .doc(userDocId)
        .collection('archive')
        .doc('main');

    final docSnapshot = await favouriteDocRef.get();

    if (!docSnapshot.exists) {
      await favouriteDocRef.set({
        'id': currentUserId,
        'archiveId': [archiveId],
      });
    } else {
      await favouriteDocRef.update({
        'archiveId': FieldValue.arrayUnion([archiveId]),
      });
    }
  }

  //-----------------deleting block user or removing  archive
  Future<void> removeArchive(String archiveId) async {
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
        .collection('archive')
        .doc('main');

    final docSnapshot = await favouriteDocRef.get();

    if (!docSnapshot.exists) return;

    // Remove the archiveId from the list
    await favouriteDocRef.update({
      'archiveId': FieldValue.arrayRemove([archiveId]),
    });

    // Re-check the updated document to see if list is now empty
    final updatedDoc = await favouriteDocRef.get();
    final data = updatedDoc.data();

    if (data != null) {
      final List<dynamic>? archiveIds = data['archiveId'];
      if (archiveIds == null || archiveIds.isEmpty) {
        // Delete the 'main' document if no more blocked IDs
        await favouriteDocRef.delete();
      }
    }
  }
//---------------fetch-------------------------------
  Future<ArchiveModel?> fetchArchives() async {
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
        .collection('archive')
        .doc('main');

    final docSnapshot = await favouriteDocRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) return null;

    return ArchiveModel.fromMap(docSnapshot.data()!);
  }
}
