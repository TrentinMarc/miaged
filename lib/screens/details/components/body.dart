import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/screens/details/components/add_to_cart.dart';
import 'package:miaged/screens/details/components/description.dart';
import 'package:miaged/screens/details/components/product_title_with_image.dart';
import 'package:miaged/tools/constant.dart';

import 'brand_size.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                    left: defaultPadding,
                    right: defaultPadding,
                  ),
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Color(colorSchemeSubBar),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      BrandAndSize(product: widget.product),
                      const SizedBox(height: defaultPadding / 2),
                      Description(product: widget.product),
                      const SizedBox(height: defaultPadding / 2),
                      // CounterWithFavBtn(),
                      const SizedBox(height: defaultPadding),
                      AddToCart(product: widget.product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: widget.product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
