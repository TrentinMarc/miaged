import 'package:flutter/material.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/screens/home/home_page.dart';
import 'package:miaged/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return LoginDemo();
    } else {
      return HomePage();
    }
  }
}
