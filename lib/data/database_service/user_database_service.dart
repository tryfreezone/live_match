import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:live_match/data/data_model/user_model.dart';
import 'package:live_match/logic/locator.dart';


class UserDatabaseService {

  Future<void> getUserData(User user) async {
   var documentSnapshot =
        await Locator.firestoreService.userColRef.doc(user.uid).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      UserModel userModel = UserModel.fromJson(data: data, user: user);
      createUserInLocal(userModel);
    } else {

      UserModel userModel = await createNewUser(user);

      createUserInLocal(userModel);
    }
  }
   Future<UserModel> createNewUser(User user) async {
    UserModel userModel = UserModel(
      uid: user.uid,
      displayName: user.displayName ?? "",
      name: user.displayName ?? "",
      email: user.email ?? "",
      photoURL: user.photoURL ?? "",
      passwordVerified: user.emailVerified,
      userType: "admin",
      profileComplete: false,
    );
        

    var payload = userModel.toJson();

    await Locator.firestoreService.userColRef
        .doc(user.uid)
        .set(payload, SetOptions(merge: true))
        .then((_) {
    });
    return userModel;
  }



  Future<UserModel> readUserFromRemote(User user) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    Map<String, dynamic> data =
      (documentSnapshot.data() as Map<String, dynamic>?) ?? {};
    UserModel userModel = UserModel.fromJson(data: data, user: user);
    return userModel;
  }

  Future<void> createUserInLocal(UserModel userModel) async {
    if (Locator.hiveService.userBox!.isNotEmpty) {
      await deleteUserFromLocal();
    }
    await Locator.hiveService.userBox?.put(userModel.uid, userModel);
  }

  Future<UserModel?> readUserFromLocal() async {
    var user = Locator.hiveService.userBox?.getAt(0);
    return user;
  }

  Future<void> updateUserInLocal(UserModel userModel) async {
    await Locator.hiveService.userBox?.put(userModel.uid, userModel);
  }

  Future<void> updateUserInRemote(UserModel userModel) async {
    if (userModel.uid == null) return;
    await Locator.firestoreService.userColRef
        .doc(userModel.uid)
        .set(userModel.toJson(), SetOptions(merge: true));
  }

  Future<void> updateUser(UserModel userModel) async {
    await updateUserInRemote(userModel);
    await updateUserInLocal(userModel);
  }

  deleteUserFromLocal() async {
    await Locator.hiveService.userBox?.clear();
  }
}
