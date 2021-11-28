import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/services/authentication.dart';

class UserService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future getUserDocId() async {
    try {
      final AuthenticationService _authenticationService =
          AuthenticationService();
      var userDocId;
      await _store
          .collection(User.COLLECTION_NAME)
          .where(User.USER_UID,
              isEqualTo: _authenticationService.getCurrentUserId())
          .get()
          .then((value) => {
                if (value.docs.isNotEmpty)
                  {userDocId = value.docs[0].id}
                else
                  {userDocId = ""}
              });
      return userDocId;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      var userDocId = await getUserDocId();
      DocumentSnapshot documentSnapshot =
          await _store.collection(User.COLLECTION_NAME).doc(userDocId).get();
      if (documentSnapshot.exists) {
        User _currentUser = User.fromSnapshot(documentSnapshot);
        return _currentUser;
      }
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future updateUser(User user) async {
    try {
      var userDocId = await getUserDocId();
      await _store.collection(User.COLLECTION_NAME).doc(userDocId).update({
        User.LOGIN: user.login,
        User.PASSWORD: user.password,
        User.ADDRESS: user.address,
        User.POSTAL_CODE: user.postalCode,
        User.BIRTHDAY_DATE: user.birthDayDate
      });
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
