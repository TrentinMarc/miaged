
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:miaged/models/user.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final controller = StreamController<AppUser>();

  AppUser? _userFromFirebaseUser(User? user){
    if(user != null){
      return AppUser(uid: user.uid);
    }else{
      return null;
    }

  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  Future signInWithEmailAndPwd(String email, String pwd) async{
    try{
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async{
    // try{
    //   return await _auth.signOut();
    // } catch(exception){
    //   print(exception.toString());
    //   return null;
    // }
    try{
      UserCredential result =
      await _auth.signInWithEmailAndPassword(email: "marc.trentin06@gmail.com", password: "abcdef");
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(exception){
      print(exception.toString());
      return null;
    }
  }
  Future registerWithEmailAndPwd(String email, String pwd) async{
    try{
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
      User? user = result.user;

      return _userFromFirebaseUser(user!);
    } catch(exception){
      print(exception.toString());
      return null;
    }
  }
}