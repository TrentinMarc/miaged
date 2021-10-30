import 'package:miaged/models/product_family.dart';

class Product{
  final String id;
  final String title;
  final double price;
  final String size;
  final String family;
  final String picLink;

  Product(this.id, this.title, this.size, this.price, this.family, this.picLink);
}