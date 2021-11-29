import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/models/product_family.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/services/user_service.dart';

class ProductService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

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

  Future addToCart(String idProduct) async {
    try {
      final UserService _userService = UserService();
      var userDocId = await _userService.getUserDocId();
      if (userDocId != "" && userDocId != null) {
        await _store
            .collection(User.COLLECTION_NAME)
            .doc(userDocId)
            .collection(User.SUB_COLLECTION_CART_NAME)
            .add({User.SUB_COLLECTION_CART_ID_PRODUCT: idProduct})
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
      final UserService _userService = UserService();
      var userDocId = await _userService.getUserDocId();

      List<String> products = [];
      QuerySnapshot querySnapshot = await _store
          .collection(User.COLLECTION_NAME)
          .doc(userDocId)
          .collection(User.SUB_COLLECTION_CART_NAME)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          products.add(doc[User.SUB_COLLECTION_CART_ID_PRODUCT]);
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
      List<Product> products = [];
      final UserService _userService = UserService();
      var userDocId = await _userService.getUserDocId();
      QuerySnapshot querySnapshot = await _store
          .collection(User.COLLECTION_NAME)
          .doc(userDocId)
          .collection(User.SUB_COLLECTION_CART_NAME)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          await getOne(doc[User.SUB_COLLECTION_CART_ID_PRODUCT])
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
      final UserService _userService = UserService();
      var userDocId = await _userService.getUserDocId();
      QuerySnapshot querySnapshot = await _store
          .collection(User.COLLECTION_NAME)
          .doc(userDocId)
          .collection(User.SUB_COLLECTION_CART_NAME)
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
      final UserService _userService = UserService();
      var userDocId = await _userService.getUserDocId();
      CollectionReference ref = _store
          .collection(User.COLLECTION_NAME)
          .doc(userDocId)
          .collection(User.SUB_COLLECTION_CART_NAME);

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

  Future<List<Product>> getProductsByFamily(ProductFamily family) async {
    try {
      List<Product> products = [];
      if(family.title == ProductFamily.ALL_FAMILY_VALUE){
        products = await getProducts();
      }else{
        QuerySnapshot querySnapshot =
        await _store.collection(Product.COLLECTION_NAME).where(
            Product.FAMILY, isEqualTo: family.id).get();
        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs.toList()) {
            products.add(Product.fromSnapshot(doc));
          }
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
      final UserService _userService = UserService();
      var userDocId = await _userService.getUserDocId();
      var ret = false;
      await _store
          .collection(User.COLLECTION_NAME)
          .doc(userDocId)
          .collection(User.SUB_COLLECTION_CART_NAME)
          .where(User.SUB_COLLECTION_CART_ID_PRODUCT, isEqualTo: id)
          .limit(1)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs.toList()) {
            doc.reference.delete();
            ret = true;
          }
        }
      });
      return ret;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
