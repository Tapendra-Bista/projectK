import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/signup/models/signup_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

///------------------ Repository for handling sign-up logic------------------
class SignupRepository extends BaseRepository {
  final AppGetStorage appGetStorage = AppGetStorage();

  String? errorMessge;

  SignupRepository({FirebaseAuth? firebaseAuth});

  ///-------------------- Sign up a user with email and password----------------------------
  Future<UserCredential?> signupWithEmail(SignUpModel signupModel) async {
    try {
      await auth.setLanguageCode(appGetStorage.getLanguageCode());
      final UserCredential credential =
          await auth.createUserWithEmailAndPassword(
        email: signupModel.email,
        password: signupModel.password,
      );
      debugPrint("Current user ID :${credential.user!.uid}");
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Exception: ${e.code} - ${e.message}');

      if (e.code == 'weak-password') {
        errorMessge = EnumLocale.weakPassword.name.tr;
      } else if (e.code == 'email-already-in-use') {
        errorMessge = EnumLocale.emailAlreadyExists.name.tr;
      } else {
        errorMessge = EnumLocale.defaultError.name.tr;
      }
    } catch (e) {
      errorMessge = EnumLocale.defaultError.name.tr;
    }

    return null;
  }
}
