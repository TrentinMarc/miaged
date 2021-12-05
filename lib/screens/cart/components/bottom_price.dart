import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/services/product_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';

class CartBottom extends StatefulWidget {
  const CartBottom({Key? key}) : super(key: key);

  @override
  _CartBottomState createState() => _CartBottomState();
}

class _CartBottomState extends State<CartBottom> {
  final ProductService _productService = ProductService();
  late Future<double> totalPrice;

  @override
  Widget build(BuildContext context) {
    totalPrice = _productService.getCartTotalPrice();
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
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            flex: 3,
          ),
          Flexible(
            child: Container(
              child: Center(
                child: FutureBuilder<double>(
                    future: totalPrice,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final price = snapshot.data;
                        return Text(
                          price!.toStringAsFixed(2) + " €",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w300),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const DogoProgressIndicator();
                    }),
              ),
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
