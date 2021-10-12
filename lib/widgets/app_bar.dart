import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/services/auth_service.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Miaged",
        style: GoogleFonts.comfortaa(
            color: Colors.black, fontSize: 35, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: Colors.amber,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          context.read<AuthenticationService>().signOut();
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
