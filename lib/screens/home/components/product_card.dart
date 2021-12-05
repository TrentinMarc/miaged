import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';

import '../../../tools/constant.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function() press;

  const ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              width: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: product.id,
                child: Image.network(product.picLink),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
            child: Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Text(
            product.brand,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic),
          ),
          Text(
            "${product.price.toString()}€ | ${product.size}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
