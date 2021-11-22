import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartBottom extends StatefulWidget {
  const CartBottom({Key? key}) : super(key: key);

  @override
  _CartBottomState createState() => _CartBottomState();
}

class _CartBottomState extends State<CartBottom> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          Flexible(
            child: Container(
              child: Center(
                child: Text(
                  "Total",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w300),
                ),
              ),
              color: Colors.red,
            ),
            flex: 3,
          ),
          Flexible(
            child: Container(
              child: Center(
                child: Text(
                  "250 \$",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w300),
                ),
              ),
              color: Colors.pink,
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
