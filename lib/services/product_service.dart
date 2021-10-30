import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/models/product_family.dart';
import 'package:miaged/models/user.dart';

class ProductService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readProducts(){
    CollectionReference products = _store.collection("products");

    return products.snapshots();
  }
  Future<List<Product>?> getProducts() async{
    try{
      List<Product> products = [];
      QuerySnapshot querySnapshot =
      await _store.collection("products").get();
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList()){
          print(doc.data());
          Product p = Product(doc["id"], doc["Title"], doc["Size"], doc["Price"], doc["Family"], doc["PicLink"]);
          products.add(p);
        }
      }
      return products;
    }catch(exception){
      print(exception.toString());
      return null;
    }

  }
}