import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartHeader extends StatefulWidget {
  const CartHeader({Key? key}) : super(key: key);

  @override
  _CartHeaderState createState() => _CartHeaderState();
}

class _CartHeaderState extends State<CartHeader> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        color: Colors.red,
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
                Text(
                  "Item : 8",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
