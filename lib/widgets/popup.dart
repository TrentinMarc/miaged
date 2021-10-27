import 'package:flutter/material.dart';
class Popup extends StatelessWidget {
  final String popupName;
  final String popupMessage;
  const Popup({Key? key, required this.popupName, required this.popupMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(popupName),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(popupMessage),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },

          child: const Text('Close'),
        ),
      ],
    );
  }
}