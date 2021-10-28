import 'package:flutter/material.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/widgets/app_bar.dart';
import 'package:miaged/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
      ),
      bottomNavigationBar: const BottomNavBar()
    );
  }
}

