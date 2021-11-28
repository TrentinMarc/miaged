import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constant.dart';
import 'package:miaged/services/product_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';

class CartHeader extends StatefulWidget {
  const CartHeader({Key? key}) : super(key: key);

  @override
  _CartHeaderState createState() => _CartHeaderState();
}

class _CartHeaderState extends State<CartHeader> {
  final ProductService _productService = ProductService();
  late Future<int> cartLength;

  @override
  Widget build(BuildContext context) {
    cartLength = _productService.getCartLength();
    return Flexible(
      flex: 1,
      child: Container(
        color: const Color(colorSchemeSubBar),
        child: Center(
          child: FittedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "My cart",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<int>(
                    future: cartLength,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final length = snapshot.data;
                        return Text(
                          "Item : " + length.toString(),
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const DogoProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
