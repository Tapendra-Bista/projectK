import 'package:afriqueen/features/block/model/block_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class BlockRepository extends BaseRepository {
  BlockRepository({FirebaseFirestore? firestore});

  //-------------------------- Add Block --------------------------
  Future<void> addBlock(String blockId) async {
    final blockDocRef = firestore
        .collection('users')
        .doc(currentUserId)
        .collection('block')
        .doc('main');

    final docSnapshot = await blockDocRef.get();
    final BlockModel blockModel =
        BlockModel(id: currentUserId, blockId: [blockId]);
    if (!docSnapshot.exists) {
      await blockDocRef.set(blockModel.toMap());
    } else {
      await blockDocRef.update({
        'blockId': FieldValue.arrayUnion([blockId]),
      });
    }
  }

  //-------------------------- Remove Block --------------------------
  Future<void> removeBlock(String blockId) async {
    final blockDocRef = firestore
        .collection('users')
        .doc(currentUserId)
        .collection('block')
        .doc('main');

    final docSnapshot = await blockDocRef.get();
    if (!docSnapshot.exists) return;

    await blockDocRef.update({
      'blockId': FieldValue.arrayRemove([blockId]),
    });

    final updatedDoc = await blockDocRef.get();
    final data = updatedDoc.data();

    if (data != null) {
      final List<dynamic>? blockIds = data['blockId'];
      if (blockIds == null || blockIds.isEmpty) {
        await blockDocRef.delete();
      }
    }
  }

  //-------------------------- Fetch Blocks --------------------------
  Future<BlockModel?> fetchBlocks() async {
    debugPrint("currentUserId : $currentUserId");

    final blockDocRef = firestore
        .collection('users')
        .doc(currentUserId)
        .collection('block')
        .doc('main');

    final docSnapshot = await blockDocRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) return null;

    return BlockModel.fromMap(docSnapshot.data()!);
  }
}
