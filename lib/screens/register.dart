import 'package:flutter/material.dart';
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