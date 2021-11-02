import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Popup extends StatefulWidget {
  final String popupName;
  final String popupMessage;


  const Popup({Key? key, required this.popupName, required this.popupMessage}) : super(key: key);

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup>
      with SingleTickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
    );

    controller.addStatusListener((status) async {
      if(status == AnimationStatus.completed){
        // controller.reset();
      }
    });
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.popupName,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
            color: Colors.black, fontSize: 35,
        )
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
              'assets/lotties/error.json',
              repeat: false,
              controller: controller,
            onLoaded: (composotion){
                controller.duration = composotion.duration;
                controller.forward();
            }
          ),
          Text(widget.popupMessage,
            style: GoogleFonts.openSans(
                color: Colors.black, fontSize: 20),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },

          child: const Text('Fermer'),
        ),
      ],
    );
  }
}