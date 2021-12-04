import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/tools/constant.dart';
import 'package:miaged/tools/validators.dart';
import 'package:miaged/widgets/app_bar.dart';
import 'package:miaged/widgets/popup.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService =
        AuthenticationService();
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 40, bottom: 0),
              child: Text(
                "Reset your password",
                style: GoogleFonts.comfortaa(fontSize: 30, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SizedBox(
                    width: 400,
                    height: 150,
                    child: Image.network(
                        'https://petsreviewpro.com/wp-content/uploads/2021/09/_Graphique-de-croissance-du-Rhodesian-Ridgeback-%E2%80%93-Poids-et-taille-par-age.jpg')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Type your email address, if an account is lniked to this email, you'll get a reset email in few minutes...",
                textAlign: TextAlign.center,
                style: GoogleFonts.comfortaa(fontSize: 15, color: Colors.black),
              ),
            ),
            Padding(
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                onSurface: Colors.transparent,
                                primary: const Color(colorSchemeBar)),
                            onPressed: () async {
                              var mail = emailController.text.trim();
                              if (Validators.validateEmail(mail) == null) {
                                await _authenticationService
                                    .resetPassword(mail);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const Popup(
                                    popupName: "Password Reseted",
                                    popupMessage:
                                        "Your password has been reseted, let's check your emails",
                                    popupStyle: popupSuccess,
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const Popup(
                                    popupName: "Error",
                                    popupMessage: "Unvalid Email",
                                    popupStyle: popupError,
                                  ),
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            label: const Text("Reset my password"),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
