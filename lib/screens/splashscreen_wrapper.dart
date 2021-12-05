import 'package:flutter/material.dart';
import 'package:miaged/models/app_user.dart';
import 'package:miaged/screens/landing_page.dart';
import 'package:miaged/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return const LoginDemo();
    } else {
      return const LandingPage();
    }
  }
}
