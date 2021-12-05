import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';

import '../../../tools/constant.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.title,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Price\n",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 26)),
                    TextSpan(
                      text: "${product.price} €",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 45.0),
              Expanded(
                  child: SizedBox(
                height: 220,
                child: Hero(
                  tag: product.id,
                  child: Image.network(
                    product.picLink,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
