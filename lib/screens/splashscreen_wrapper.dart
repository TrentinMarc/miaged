import 'package:flutter/material.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/screens/home_page.dart';
import 'package:miaged/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("a");
    final user = Provider.of<AppUser?>(context);
    if(user == null){
      return LoginDemo();
    }else{
      print("user id : " + user.uid);
      return HomePage();

    }
  }
}
