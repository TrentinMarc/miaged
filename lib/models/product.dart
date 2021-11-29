import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const COLLECTION_NAME = "products";
  static const ID = "id";
  static const TITLE = "Title";
  static const PRICE = "Price";
  static const SIZE = "Size";
  static const FAMILY = "Family";
  static const PIC_LINK = "PicLink";
  static const DESCRIPTION = "Description";
  static const BRAND = "Brand";

  late String _id;
  late String _title;
  late double _price;
  late String _size;
  late String _family;
  late String _picLink;
  late String _description;
  late String _brand;

  String get id => _id;

  String get title => _title;

  double get price => _price;

  String get size => _size;

  String get family => _family;

  String get picLink => _picLink;

  String get description => _description;

  String get brand => _brand;

  Product(this._id, this._title, this._size, this._price, this._family,
      this._picLink, this._description, this._brand);

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.id;
    _title = snapshot[TITLE];
    _size = snapshot[SIZE];
    _price = snapshot[PRICE];
    _family = snapshot[FAMILY];
    _picLink = snapshot[PIC_LINK];
    _description = snapshot[DESCRIPTION];
    _brand = snapshot[BRAND];
  }

  @override
  String toString() {
    return 'Product{_id: $_id, _title: $_title, _price: $_price, _size: $_size, _family: $_family, _picLink: $_picLink, _description: $_description, _brand: $_brand}';
  }
}
