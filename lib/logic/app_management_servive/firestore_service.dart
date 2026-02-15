
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference userColRef =
      FirebaseFirestore.instance.collection('users');


  init() async {}
}