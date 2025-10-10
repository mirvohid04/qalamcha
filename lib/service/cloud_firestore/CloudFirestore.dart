import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';


class CloudFirestore {
  Future<void> saveUserToFirestore(UserModel user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set(user.toJson());
  }
  Stream<List<UserModel>> getAllUsers() {
    return FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
  }


}