// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductFamily {
  late String _id;
  late String _title;

  static const COLLECTION_NAME = "product_family";
  static const TITLE = "Title";

  // Valeur par défaut permettant de consulter toutes les familles de produits
  static const ALL_FAMILY_VALUE = "Tous";

  String get id => _id;

  String get title => _title;

  ProductFamily(this._id, this._title);

  ProductFamily.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.id;
    _title = snapshot[TITLE];
  }
}
