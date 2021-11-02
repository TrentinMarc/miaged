import 'package:flutter/material.dart';
import 'package:miaged/screens/home/home_page.dart';
import 'package:miaged/screens/register.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/widgets/popup.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginDemo extends StatefulWidget {
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
      backgroundColor: Colors.white,
      // appBar: MyAppBar(),
      appBar: AppBar(
        title: Text(
          "Miaged",
          style: GoogleFonts.comfortaa(
              color: Colors.black, fontSize: 35, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 40, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Connexion",
                style: GoogleFonts.comfortaa(fontSize: 30, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
              child: Center(
                child: Container(
                    width: 400,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/cover.jpg')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                style: GoogleFonts.comfortaa(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Login',
                    hintText: 'abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: pwdController,
                obscureText: true,
                style: GoogleFonts.comfortaa(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Saisir un mdp sécurisé'),
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Mot de passe oublié ?',
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
                  // context.read<AuthenticationService>().signIn(
                  //     email: emailController.text.trim(),
                  //     password: pwdController.text.trim());
                  var email = emailController.text.trim();
                  var pwd = pwdController.text.trim();
                  var result = await _authenticationService.signInWithEmailAndPwd(email, pwd);
                  if(result == null){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const Popup(popupName: "Erreur", popupMessage: "Identifiants incorrects",),
                    );
                  }
                },
                child: Text(
                  'Se connecter',
                  style:
                      GoogleFonts.comfortaa(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Nouvel utilisateur ?',
              style: GoogleFonts.comfortaa(fontSize: 12, color: Colors.black),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text(
                  'Créer un compte',
                  style:
                      GoogleFonts.comfortaa(fontSize: 12, color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
