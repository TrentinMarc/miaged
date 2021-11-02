import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miaged/screens/home/home_page.dart';
import 'package:miaged/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miaged/screens/splashscreen_wrapper.dart';
import 'package:miaged/services/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Miaged',
        home: SplashScreenWrapper(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreenWrapper(),
      ),
    );
  }
}
