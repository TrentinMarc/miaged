import 'package:flutter/material.dart';
import 'package:miaged/screens/cart/components/header.dart';

import 'components/bottom_price.dart';
import 'components/cart_body.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void callBack() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartHeader(),
        CartBody(
          callBackParent: callBack,
        ),
        CartBottom(),
      ],
    );
  }
}
