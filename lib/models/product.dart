import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  static const COLLECTION_NAME = "products";
  static const ID = "id";
  static const TITLE = "Title";
  static const PRICE = "Price";
  static const SIZE = "Size";
  static const FAMILY = "Family";
  static const PIC_LINK = "PicLink";

   late String _id;
   late String _title;
   late double _price;
   late String _size;
   late String _family;
   late String _picLink;

   String get id => _id;
   String get title => _title;
   double get price => _price;
   String get size => _size;
   String get family => _family;
   String get picLink => _picLink;

  Product(this._id, this._title, this._size, this._price, this._family, this._picLink);

  Product.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.id;
    _title = snapshot[TITLE];
    _size = snapshot[SIZE];
    _price = snapshot[PRICE];
    _family = snapshot[FAMILY];
    _picLink = snapshot[PIC_LINK];
  }

   @override
  String toString() {
    return 'Product{_id: $_id, _title: $_title, _price: $_price, _size: $_size, _family: $_family, _picLink: $_picLink}';
  }
}