import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../tools/constant.dart';

class DogoProgressIndicator extends StatefulWidget {
  const DogoProgressIndicator({Key? key}) : super(key: key);

  @override
  _DogoProgressIndicatorState createState() => _DogoProgressIndicatorState();
}

class _DogoProgressIndicatorState extends State<DogoProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
    );

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // controller.reset();
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
    return Lottie.asset(lottieDogo, repeat: true, controller: controller,
        onLoaded: (composotion) {
      controller.duration = composotion.duration;
      controller.forward();
    }, height: 100, width: 100);
  }
}
