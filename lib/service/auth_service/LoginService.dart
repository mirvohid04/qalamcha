import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qalamcha/models/user_model.dart';
import 'package:qalamcha/service/auth_service/SharedpreferencesService.dart';




class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalStorageService _localStorage = LocalStorageService();

  Future<User?> registerWithEmail(
      String email,
      String password,
      String lastName,
      String firstName,
      ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: user.email!,
          firstName: firstName,
          lastName: lastName,
          createdAt: DateTime.now().toString(),
        );

        await _firestore.collection("users").doc(user.uid).set(userModel.toJson());

        await _localStorage.saveUser(userModel);
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await getUserData(result.user!.uid);

      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _localStorage.clear();
    await _auth.signOut();
  }

  Future<void> getUserData(String uid) async {
    final doc = await _firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      final user = UserModel.fromJson(doc.data()!);
      await _localStorage.saveUser(user);
    }
  }

  Stream<User?> get userChanges => _auth.authStateChanges();
}
