import 'package:flutter/material.dart';
import 'package:miaged/constant.dart';
import 'package:miaged/screens/cart/cart_screen.dart';
import 'package:miaged/screens/home/home_page.dart';
import 'package:miaged/screens/profile/profile_screen.dart';

typedef void IntCallback(int val);

class BottomNavBar extends StatefulWidget {
  final IntCallback callback;

  const BottomNavBar({Key? key, required this.callback}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 1;
  var screens = [CartScreen(), HomePage(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: currentIndex,
      selectedItemColor: const Color(colorSchemeItem),
      unselectedItemColor: Colors.white,
      selectedFontSize: 16,
      iconSize: 30,
      onTap: (index) {
        setState(() => currentIndex = index);
        widget.callback(currentIndex);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_sharp),
          label: "Cart",
          backgroundColor: Color(colorSchemeBar),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: "Buy",
          backgroundColor: Color(colorSchemeBar),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: "Profile",
          backgroundColor: Color(colorSchemeBar),
        ),
      ],
    );
  }
}
