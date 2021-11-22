import 'package:flutter/material.dart';
import 'package:miaged/screens/cart/components/header.dart';

import 'components/bottom_price.dart';
import 'components/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CartHeader(),
        Flexible(
          flex: 4,
          child: CartItem(),
        ),
        const CartBottom(),
      ],
    );
  }
}
