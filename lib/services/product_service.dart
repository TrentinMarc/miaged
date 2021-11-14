import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/models/user.dart';

class ProductService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future getUserDocId(String idUser) async {
    try {
      var userDocId;
      await _store
          .collection(AppUser.COLLECTION_NAME)
          .where(AppUser.UID, isEqualTo: idUser)
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

  Future addToCart(String idProduct, String idUser) async {
    try {
      var userDocId = await getUserDocId(idUser);
      if (userDocId != "" && userDocId != null) {
        await _store
            .collection(AppUser.COLLECTION_NAME)
            .doc(userDocId)
            .collection(AppUser.SUB_COLLECTION_CART_NAME)
            .add({AppUser.SUB_COLLECTION_CART_ID_PRODUCT: idProduct})
            .then((_) => print("Correctly added to cart"))
            .catchError((error) => print("Add to cart fail : " + error));
      } else {
        return null;
      }
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<List<String>> getUserCart(String idUser) async {
    try {
      List<String> products = [];
      var userDocId = await getUserDocId(idUser);
      QuerySnapshot querySnapshot = await _store
          .collection(AppUser.COLLECTION_NAME)
          .doc(userDocId)
          .collection(AppUser.SUB_COLLECTION_CART_NAME)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          products.add(doc[AppUser.SUB_COLLECTION_CART_ID_PRODUCT]);
        }
      }
      return products;
    } catch (exception) {
      print(exception);
      return [];
    }
  }

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

  Future<bool> isProductAlreadyInCart(String idProduct, String idUser) async {
    try {
      List<String> userCartItemsId = await getUserCart(idUser);
      if (userCartItemsId.contains(idProduct)) {
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      print(exception);
      return true;
    }
  }
}
