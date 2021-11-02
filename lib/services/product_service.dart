import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/models/product.dart';

class ProductService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    try {
      List<Product> products = [];
      QuerySnapshot querySnapshot =
          await _store.collection(Product.COLLECTION_NAME).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          products.add(Product.fromSnapshot(doc));
        }
      }
      return products;
    } catch (exception) {
      print(exception);
      return [];
    }
  }
}
