import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/product_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart>
    with SingleTickerProviderStateMixin {
  final AuthenticationService _authenticationService = AuthenticationService();
  final ProductService _productService = ProductService();
  late bool isDisabled;
  late AnimationController controller;

  Future<bool> getDisabledState() async {
    return await _productService.isProductAlreadyInCart(widget.product.id);
  }

  @override
  void initState() {
    super.initState();
    getDisabledState().then((value) {
      isDisabled = value;
      setState(() {});
    });
  }

  _addToCart() async {
    await _productService.addToCart(widget.product.id);
    getDisabledState().then((value) {
      isDisabled = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDisabledState(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DogoProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                        height: 70,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              onSurface: Colors.transparent),
                          onPressed: isDisabled ? null : _addToCart,
                          icon: const Icon(
                            Icons.shopping_cart_sharp,
                            color: Colors.white,
                          ),
                          label: Text(
                            isDisabled
                                ? "Déjà présent dans le panier"
                                : "Ajouter au panier",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
            );
          }
        });
  }
}
