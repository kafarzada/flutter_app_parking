import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkink_app/models/UserModel.dart';
//import 'package:parkink_app/models/UserModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _clientCollection =
        FirebaseFirestore.instance.collection("client");

  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return UserModel.fromFirebase(user);
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<UserModel> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      Map d  = new Map<String, dynamic>();
      d['email'] = email;
      d["cars"] = 0;
      d["bonus"] = 0;
      d["registrationDate"] = DateTime.now();
      await _clientCollection.doc(user.uid).set(d);
      return UserModel.fromFirebase(user);
    } catch(e) {
      return null;
    }
  }

  Future logOut() async{
    await _auth.signOut();
  }

  Stream<UserModel> get currentUser{
    return _auth.authStateChanges()
        .map((User user) =>  user != null ? UserModel.fromFirebase(user) : null);
  }
}