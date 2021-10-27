import 'package:flutter/material.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/widgets/app_bar.dart';

class HomePage extends StatelessWidget {

  final AuthenticationService _authenticationService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        child: ElevatedButton(
            onPressed: () async {
              await _authenticationService.signOut();
            },
            child: Text("Se déco")),
      ),
    );
  }
}
