import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/models/clothe.dart';
import 'package:miaged/models/user.dart';

class ClothesService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(user.uid) : null;
  }

  Future getClothes() async{
    try{
      List<Clothe> clothes;
      QuerySnapshot querySnapshot =
      await _store.collection("clothes").get();
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList()){
          clothes.add(Clothe(doc.["title"], size, price, family))
          print(doc.data().toString());
        }
      }
      return null;
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }
}