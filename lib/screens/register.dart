import 'package:flutter/material.dart';
import 'package:miaged/screens/login_screen.dart';
import 'package:miaged/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:miaged/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  static const pageName = "/registerPage";
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Miaged",
          style: GoogleFonts.comfortaa(
              color: Colors.black, fontSize: 35, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      //   leading: IconButton(
      //   icon: Icon(Icons.arrow_back, color: Colors.black,),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => LoginDemo()),
      //     );
      //   },
      // ),
      ),
    );
  }
}