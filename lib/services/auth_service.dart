import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpinghands/models/user_model.dart' as model;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sigUpUser(String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print("Signed in");
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> sigInUser(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print("Signed in");
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> sigInAnonymously() async {
    await _auth.signInAnonymously().then((user) {
      print("Signed in as Anonymous");
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> signOut() async {
    await _auth.signOut().then((user) {
      print("Signed out");
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<model.User> getCurrentUser() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromJson(snapshot);
  }
}
