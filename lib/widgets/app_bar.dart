import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/product_service.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AuthenticationService _authenticationService = AuthenticationService();
  final ProductService _productService = ProductService();

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Miaged",
        style: GoogleFonts.comfortaa(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: Colors.blueGrey,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border_outlined),
          onPressed: () async {
            // await _authenticationService.signOut();
            await _productService
                .getUserCart(_authenticationService.getCurrentUserId());
          },
        ),
      ],
    );
  }
}
