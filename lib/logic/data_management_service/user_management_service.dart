import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:live_match/data/data_model/user_model.dart';
import 'package:live_match/logic/locator.dart';

class UserManagementService {
  final userData = ValueNotifier<UserModel?>(null);

  final invalidUser = ValueNotifier<bool>(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> init() async {
    Locator.hiveService.userBox?.watch().listen((event) {
      userData.value = event.value;
      if (event.deleted) {
        userData.value = null;
      }
    });
    _auth.authStateChanges().listen((user) async {
      Locator.navigationService.isLoadingNotifier.value = true;
      if (user != null) {
        if (userData.value != null) {
          if (user.uid != userData.value!.uid) {
            await Locator.userDatabaseService.deleteUserFromLocal();
          }
        }
        if (Locator.hiveService.userBox!.isEmpty) {
          await Locator.userDatabaseService.getUserData(user);
          await Locator.startupService.setupApplicationData();
        }
      } else {}
      Locator.navigationService.isLoadingNotifier.value = false;
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      Locator.navigationService.isLoadingNotifier.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      invalidUser.value = !invalidUser.value;
      Locator.navigationService.isLoadingNotifier.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      Locator.navigationService.isLoadingNotifier.value = true;

      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          Locator.navigationService.isLoadingNotifier.value = false;
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
      }
    } catch (error) {
      invalidUser.value = !invalidUser.value;
    } finally {
      Locator.navigationService.isLoadingNotifier.value = false;
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      Locator.navigationService.isLoadingNotifier.value = true;

      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken;
        if (accessToken == null) {
          Locator.navigationService.isLoadingNotifier.value = false;
          return;
        }

        final credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        await _auth.signInWithCredential(credential);
      } else {
        Locator.navigationService.isLoadingNotifier.value = false;
        return;
      }
    } catch (error) {
      invalidUser.value = !invalidUser.value;
    } finally {
      Locator.navigationService.isLoadingNotifier.value = false;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      Locator.navigationService.isLoadingNotifier.value = true;

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        if (name != null && name.isNotEmpty) {
          await user.updateDisplayName(name);
        }

        await Locator.userDatabaseService.createNewUser(user);
        await Locator.startupService.setupApplicationData();
      }
    } catch (error) {
      invalidUser.value = !invalidUser.value;
      Locator.navigationService.isLoadingNotifier.value = false;
    }
  }

  Future<void> updateBasicProfile({
    required String name,
    required String age,
    required String location,
    required String favoriteSport,
    required String contactNumber,
  }) async {
    final current = userData.value;
    if (current == null) return;

    final updated = UserModel(
      displayName: current.displayName,
      userName: current.userName,
      password: current.password,
      name: name,
      email: current.email,
      phoneNumber: contactNumber,
      address: current.address,
      photoURL: current.photoURL,
      passwordVerified: current.passwordVerified,
      uid: current.uid,
      userType: current.userType,
      age: age,
      location: location,
      favoriteSport: favoriteSport,
      profileComplete: true,
    );

    await Locator.userDatabaseService.updateUser(updated);
    userData.value = updated;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await Locator.hiveService.clearAllBox();
  }
}
