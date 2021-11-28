import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/screens/cart/components/cart_item.dart';
import 'package:miaged/services/product_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';

class CartBody extends StatefulWidget {
  const CartBody({
    Key? key,
    required this.callBackParent,
  }) : super(key: key);
  final Function callBackParent;

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> userCart;

  @override
  Widget build(BuildContext context) {
    userCart = _productService.getUserCart();
    return Flexible(
      flex: 6,
      child: FutureBuilder<List<Product>>(
          future: userCart,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final cart = snapshot.data;
              return ListView.builder(
                  itemCount: cart!.length,
                  itemBuilder: (BuildContext context, int index) => CartItem(
                        product: cart[index],
                        callback: widget.callBackParent,
                      ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const DogoProgressIndicator();
          }),
    );
  }
}
