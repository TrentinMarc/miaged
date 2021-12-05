import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/screens/register.dart';
import 'package:miaged/screens/reset_password.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/tools/constant.dart';
import 'package:miaged/widgets/app_bar.dart';
import 'package:miaged/widgets/popup.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Miaged",
      //     style: GoogleFonts.comfortaa(
      //         color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: const Color(colorSchemeBarLight),
      // ),
      appBar: const MyAppBar(popable: false, title: "Miaged"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 40, bottom: 0),
              child: Text(
                "Connection",
                style: GoogleFonts.comfortaa(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
              child: Center(
                child: SizedBox(
                    width: 400,
                    height: 150,
                    child: Image.asset('assets/images/cover.jpg')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                style: GoogleFonts.comfortaa(fontSize: 16),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Login',
                    hintText: 'abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: pwdController,
                obscureText: true,
                style: GoogleFonts.comfortaa(fontSize: 16),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Type your password ...'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen()),
                );
              },
              child: Text(
                'Forgotten password ?',
                style: GoogleFonts.comfortaa(fontSize: 16, color: Colors.blue),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  var email = emailController.text.trim();
                  var pwd = pwdController.text.trim();
                  var result = await _authenticationService
                      .signInWithEmailAndPwd(email, pwd);
                  if (result == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const Popup(
                        popupName: "Error",
                        popupMessage: "Wrong credentials",
                        popupStyle: popupError,
                      ),
                    );
                  }
                },
                child: Text(
                  'Sign in',
                  style: GoogleFonts.comfortaa(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'New user ?',
              style: GoogleFonts.comfortaa(fontSize: 12),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: Text(
                  'Sign up',
                  style:
                      GoogleFonts.comfortaa(fontSize: 12, color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
