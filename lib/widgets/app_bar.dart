import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/tools/constant.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.popable, required this.title})
      : super(key: key);
  final bool popable;
  final String title;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _MyAppBarState extends State<MyAppBar> {
  Widget? isPopable() {
    if (widget.popable) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isPopable(),
      title: Text(
        "Miaged",
        style: GoogleFonts.comfortaa(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: const Color(colorSchemeBar),
    );
  }
}
