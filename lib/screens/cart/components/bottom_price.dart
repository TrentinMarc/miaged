import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constant.dart';
import 'package:miaged/services/product_service.dart';

class CartBottom extends StatefulWidget {
  const CartBottom({Key? key}) : super(key: key);

  @override
  _CartBottomState createState() => _CartBottomState();
}

class _CartBottomState extends State<CartBottom> {
  final ProductService _productService = ProductService();
  late Future<double> total_price;

  @override
  Widget build(BuildContext context) {
    total_price = _productService.getCartTotalPrice();
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          Flexible(
            child: Container(
              child: Center(
                child: Text(
                  "Total price",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w300),
                ),
              ),
              color: const Color(colorSchemeSubBar),
            ),
            flex: 3,
          ),
          Flexible(
            child: Container(
              child: Center(
                child: FutureBuilder<double>(
                    future: total_price,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final price = snapshot.data;
                        return Text(
                          price.toString() + " €",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w300),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
              color: const Color(colorSchemeSubBar),
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}