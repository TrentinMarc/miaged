import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/product_service.dart';
import 'package:miaged/tools/constant.dart';
import 'package:miaged/widgets/popup.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.product, required this.callback})
      : super(key: key);
  final Product product;
  final Function callback;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor),
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Image.network(
                        widget.product.picLink,
                        height: 38,
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Text(
                        widget.product.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.montserrat(fontSize: 15),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "${widget.product.price} €",
                      ),
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                  constraints: const BoxConstraints(
                      minWidth: 36, maxWidth: 36, minHeight: 36, maxHeight: 36),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  fillColor: const Color(colorSchemeMainLight),
                  splashColor: Colors.red,
                  onPressed: () async {
                    var isDeleted =
                        await _productService.removeFromCart(widget.product.id);
                    print(isDeleted);
                    if (isDeleted) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => const Popup(
                          popupName: "Done",
                          popupMessage: "Item corretly remove from cart !",
                          popupStyle: popupDeleteSuccess,
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => const Popup(
                          popupName: "Error",
                          popupMessage:
                              "Something gone wrong ... Please try again.",
                          popupStyle: popupError,
                        ),
                      );
                    }
                    widget.callback();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
