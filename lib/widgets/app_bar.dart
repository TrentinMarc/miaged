import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/clothes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);
  final AuthenticationService _authenticationService = AuthenticationService();
  final ClothesService _clothesService = ClothesService();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Miaged",
        style: GoogleFonts.comfortaa(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: Colors.amber,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          // await _authenticationService.signOut();
          await _clothesService.getClothes();
        },
      ),
      actions: const [
        IconButton(
          icon: Icon(Icons.favorite_border_outlined),
          onPressed: null,
        ),
      ],
    );
  }
}
