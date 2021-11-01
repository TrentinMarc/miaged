import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function? press;

  const ProductCard({
    Key? key,
    required this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 18.0,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: product.id,
                child: Image.network(product.picLink),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
            child: Text(
              // products is out demo list
              product.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            "\$${product.price.toString()} | ${product.size}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
