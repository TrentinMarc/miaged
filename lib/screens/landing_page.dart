import 'package:flutter/material.dart';
import 'package:miaged/screens/cart/cart_screen.dart';
import 'package:miaged/screens/home/home_page.dart';
import 'package:miaged/widgets/bottom_navigation_bar.dart';
import 'package:miaged/widgets/app_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List _children = [CartScreen(), HomePage(), CartScreen()];

  int index = 0;

  void updateIndex(int newIndex) {
    print(newIndex);
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: _children[index],
      bottomNavigationBar: BottomNavBar(
        callback: (int newIndex) {
          updateIndex(newIndex);
        },
      ),
    );
  }
}
