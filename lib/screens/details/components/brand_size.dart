import 'package:flutter/material.dart';
import 'package:miaged/constant.dart';
import 'package:miaged/models/product.dart';

class BrandAndSize extends StatelessWidget {
  const BrandAndSize({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black54),
              children: [
                const TextSpan(
                    text: "Brand\n",
                    style: TextStyle(color: Color(colorSchemeItem))),
                TextSpan(
                  text: product.brand,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black54),
              children: [
                const TextSpan(
                    text: "Size\n",
                    style: TextStyle(color: Color(colorSchemeItem))),
                TextSpan(
                  text: product.size,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}
