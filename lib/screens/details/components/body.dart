import 'package:flutter/material.dart';
import 'package:miaged/constant.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/screens/details/components/add_to_cart.dart';
import 'package:miaged/screens/details/components/description.dart';
import 'package:miaged/screens/details/components/product_title_with_image.dart';

import 'size.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.07,
                    left: DefaultPadding,
                    right: DefaultPadding,
                  ),
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: product),
                      const SizedBox(height: DefaultPadding / 2),
                      Description(product: product),
                      const SizedBox(height: DefaultPadding / 2),
                      // CounterWithFavBtn(),
                      const SizedBox(height: DefaultPadding),
                      AddToCart(product: product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}