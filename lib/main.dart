import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miaged/screens/login_screen.dart';
import 'package:miaged/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Miaged',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginDemo(),
    );
  }
}
