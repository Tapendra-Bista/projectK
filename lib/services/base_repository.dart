import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseRepository {
  // These are concrete getters — they do NOT need to be overridden
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  String get currentUserId => FirebaseAuth.instance.currentUser!.uid;
}
