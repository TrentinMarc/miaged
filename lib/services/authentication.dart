import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/models/app_user.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(user.uid) : null;
  }

  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPwd(String email, String pwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      User? user = result.user;

      return _userFromFirebaseUser(user!);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
