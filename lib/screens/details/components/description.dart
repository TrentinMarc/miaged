import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/tools/constant.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Description",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(colorSchemeItemLight)),
              textAlign: TextAlign.left,
            ),
            Text(
              product.description,
              style: const TextStyle(height: 1.5, color: Colors.white),
            ),
          ],
        ));
  }
}
