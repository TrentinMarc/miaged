import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/services/authentication.dart';

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

  Future<Product?> getOne(String idProduct) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _store.collection(Product.COLLECTION_NAME).doc(idProduct).get();
      if (documentSnapshot.exists) {
        Product _product = Product.fromSnapshot(documentSnapshot);
        return _product;
      }
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

  Future<List<String>> getUserCartIds() async {
    try {
      final AuthenticationService _authenticationService =
          AuthenticationService();
      List<String> products = [];
      var userDocId =
          await getUserDocId(_authenticationService.getCurrentUserId());
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

  Future<List<Product>> getUserCart() async {
    try {
      final AuthenticationService _authenticationService =
          AuthenticationService();
      List<Product> products = [];
      var userDocId =
          await getUserDocId(_authenticationService.getCurrentUserId());
      QuerySnapshot querySnapshot = await _store
          .collection(AppUser.COLLECTION_NAME)
          .doc(userDocId)
          .collection(AppUser.SUB_COLLECTION_CART_NAME)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          await getOne(doc[AppUser.SUB_COLLECTION_CART_ID_PRODUCT])
              .then((product) => products.add(product!));
        }
      }
      return products;
    } catch (exception) {
      print(exception);
      return [];
    }
  }

  Future<int> getCartLength() async {
    try {
      final AuthenticationService _authenticationService =
          AuthenticationService();
      var userDocId =
          await getUserDocId(_authenticationService.getCurrentUserId());
      QuerySnapshot querySnapshot = await _store
          .collection(AppUser.COLLECTION_NAME)
          .doc(userDocId)
          .collection(AppUser.SUB_COLLECTION_CART_NAME)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.length;
      } else {
        return 0;
      }
    } catch (exception) {
      print(exception);
      return 0;
    }
  }

  Stream<int> streamCartLength() async* {
    try {
      final AuthenticationService _authenticationService =
          AuthenticationService();
      var userDocId =
          await getUserDocId(_authenticationService.getCurrentUserId());
      CollectionReference ref = _store
          .collection(AppUser.COLLECTION_NAME)
          .doc(userDocId)
          .collection(AppUser.SUB_COLLECTION_CART_NAME);

      ref.snapshots().listen((querySnapshot) async* {
        print(querySnapshot.docs.length);
        yield querySnapshot.docs.length;
      });
    } catch (exception) {
      print(exception);
      yield 0;
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

  Future<bool> isProductAlreadyInCart(String idProduct) async {
    try {
      List<String> userCartItemsId = await getUserCartIds();
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

  Future<double> getCartTotalPrice() async {
    try {
      double price = -1;
      List<Product> cartList = await getUserCart();
      if (cartList != []) {
        price += 1;
        for (var product in cartList) {
          price += product.price;
        }
        return price;
      }
      return price;
    } catch (exception) {
      print(exception);
      return 0;
    }
  }

  Future removeFromCart(String id) async {
    try {
      final AuthenticationService _authenticationService =
          AuthenticationService();
      var userDocId =
          await getUserDocId(_authenticationService.getCurrentUserId());

      await _store
          .collection(AppUser.COLLECTION_NAME)
          .doc(userDocId)
          .collection(AppUser.SUB_COLLECTION_CART_NAME)
          .where(AppUser.SUB_COLLECTION_CART_ID_PRODUCT, isEqualTo: id)
          .limit(1)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs.toList()) {
            doc.reference.delete();
          }
        }
      });
    } catch (exception) {
      print(exception);
      return 0;
    }
  }
}
