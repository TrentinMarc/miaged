import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/models/product_family.dart';

class ProductFamilyService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<List<ProductFamily>> getProductFamilies() async {
    try {
      List<ProductFamily> productFamily = [];
      QuerySnapshot querySnapshot =
          await _store.collection(ProductFamily.COLLECTION_NAME).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          productFamily.add(ProductFamily.fromSnapshot(doc));
        }
      }
      return productFamily;
    } catch (exception) {
      print(exception);
      return [];
    }
  }
}
