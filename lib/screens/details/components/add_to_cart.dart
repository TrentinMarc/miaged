import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/product_service.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final ProductService _productService = ProductService();
  late bool isDisabled;

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
    await _productService.addToCart(
        widget.product.id, _authenticationService.getCurrentUserId());
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
            return const CircularProgressIndicator();
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
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 20.0),
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //         child: SizedBox(height: 50, child: _buildElevatedButton()),
    //       ),
    //     ],
    //   ),
    // );
  }

// Widget _buildElevatedButton() {
//   return ElevatedButton.icon(
//     onPressed: isDisabled ? null : _addToCart,
//     icon: const Icon(Icons.shopping_cart_sharp),
//     label: Text(
//         isDisabled ? "Déjà présent dans le panier" : "Ajouter au panier"),
//   );
// }
}
