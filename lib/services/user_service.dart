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
          .collection(MiagedUser.COLLECTION_NAME)
          .where(MiagedUser.USER_UID,
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

  Future<MiagedUser?> getCurrentUser() async {
    try {
      var userDocId = await getUserDocId();
      DocumentSnapshot documentSnapshot = await _store
          .collection(MiagedUser.COLLECTION_NAME)
          .doc(userDocId)
          .get();
      if (documentSnapshot.exists) {
        MiagedUser _currentUser = MiagedUser.fromSnapshot(documentSnapshot);
        return _currentUser;
      }
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future updateUser(MiagedUser user) async {
    try {
      var userDocId = await getUserDocId();
      await _store
          .collection(MiagedUser.COLLECTION_NAME)
          .doc(userDocId)
          .update({
        MiagedUser.LOGIN: user.login,
        MiagedUser.PASSWORD: user.password,
        MiagedUser.ADDRESS: user.address,
        MiagedUser.POSTAL_CODE: user.postalCode,
        MiagedUser.BIRTHDAY_DATE: user.birthDayDate,
        MiagedUser.AVATAR_LINK: user.avatarLink,
        MiagedUser.CITY: user.city
      });
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<Map<String, dynamic>> newUser(MiagedUser user) async {
    try {
      Map<String, dynamic> ret = {};
      await _store
          .collection(MiagedUser.COLLECTION_NAME)
          .add(MiagedUser.toJSON(user))
          .then((newUser) {
        ret = {"isCreated": true, "message": newUser.id};
      }).catchError((error) {
        ret = {"isCreated": false, "message": error.message};
      });
      return ret;
    } catch (exception) {
      print(exception);
      return {};
    }
  }
}
