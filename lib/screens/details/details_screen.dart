import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constant.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorSchemeMain),
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Description",
        style: GoogleFonts.comfortaa(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: Color(colorSchemeBar),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
