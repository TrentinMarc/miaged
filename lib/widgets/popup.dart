import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Popup extends StatefulWidget {
  final String popupName;
  final String popupMessage;
  final String popupStyle;

  const Popup(
      {Key? key,
      required this.popupName,
      required this.popupMessage,
      required this.popupStyle})
      : super(key: key);

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
    );

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        controller.reset();
        // controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.popupName,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 35,
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(widget.popupStyle, repeat: false, controller: controller,
              onLoaded: (composotion) {
            controller.duration = composotion.duration;
            controller.forward();
          }, fit: BoxFit.fill, width: 200, height: 200),
          Text(
            widget.popupMessage,
            style: GoogleFonts.openSans(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
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
