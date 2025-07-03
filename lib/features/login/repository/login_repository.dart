import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:afriqueen/features/login/models/login_model.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication;

// -------------------------Login logic-----------------------------
class LoginRepository extends BaseRepository {
  final AppGetStorage _appGetStorage = AppGetStorage();

  String? error;

  LoginRepository({FirebaseAuth? firebaseauth});

//-----------------Email Links (PasswordLess Auth)----------------
  Future<void> sendSignInLink(String email) async {
    try {
      final ActionCodeSettings acs = ActionCodeSettings(
        url:
            'https://afriqueen-e0b18.web.app', // Your app’s domain or deep link route
        handleCodeInApp: true,
        androidPackageName: "com.example.afriqueen",
        androidInstallApp: true,
        androidMinimumVersion: '21',
        iOSBundleId: "com.example.afriqueen",
      );

      await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: acs,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //------------------------------login with Email ------------------------------------------
  Future<UserCredential?> loginWithEmail(LoginModel loginModel) async {
    try {
      await auth.setLanguageCode(_appGetStorage.getLanguageCode());
      final UserCredential credential = await auth.signInWithEmailAndPassword(
        email: loginModel.email,
        password: loginModel.password,
      );

      debugPrint("Current user ID :${credential.user!.uid}");
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Exception: ${e.code} - ${e.message}');
      null; // Important: clear the credential if login fails!

      if (e.code == 'user-not-found') {
        error = EnumLocale.userNotFoundError.name.tr;
      } else if (e.code == 'wrong-password') {
        error = EnumLocale.wrongPasswordError.name.tr;
      } else {
        error = EnumLocale.wrongCredential.name.tr;
      }
    }
    return null;
  }

  //----------------------login with google----------------------------
  Future<UserCredential?> loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn.instance.authenticate();
      GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return userCredential;
    } catch (e) {
      error = EnumLocale.defaultError.name.tr;

      debugPrint(e.toString());

      //
    }
    return null;
  }

  //-------------------- checking if user available or not---------------------
  Future<bool> isUserAvailable() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(currentUserId).get();

      if (snapshot.exists) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
