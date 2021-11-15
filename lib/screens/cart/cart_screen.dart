import 'package:flutter/material.dart';
import 'package:miaged/widgets/app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: const Center(
        child: Text("Le panier"),
      ),
    );
  }
}
