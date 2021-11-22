import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[300],
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                "https://cdn.discordapp.com/attachments/331849130965991424/905123354372112484/beret-gd152535cb_1920.png",
                height: 38,
              ),
              Text(
                "NOM PRODUIT",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              const Text("Prix produit")
            ],
          ),
        ),
      ),
    );
  }
}
