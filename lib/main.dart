import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miaged/screens/home_page.dart';
import 'package:miaged/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miaged/services/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future<void> main() async {
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return HomePage();
    } else {
      return LoginDemo();
    }
  }
}
