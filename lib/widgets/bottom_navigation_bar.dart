import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      selectedFontSize: 16,
      iconSize: 30  ,
      onTap: (index) => setState(() => currentIndex = index),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_sharp),
            label: "Panier",
            backgroundColor: Color.fromRGBO(0, 85, 164, 1)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: "Acheter",
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "Profil",
            backgroundColor: Color.fromRGBO(239, 65, 53, 1)
        ),
      ],
    );
  }
}
