import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Future<void> signOut() async {
    await _auth.signOut();
    await Locator.hiveService.clearAllBox();
  }
}
